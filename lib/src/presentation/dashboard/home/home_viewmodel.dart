import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import '../../../resources/repositories/product.dart';
import '../../../resources/resources.dart';
import '../../../utils/shared_pref.dart';
import '../../presentation.dart';

class HomeViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final ProductResponse productResponse;

  HomeViewModel({
    @required this.authRepository,
    @required this.productResponse,
  });

  final _user = BehaviorSubject<User>();
  final _popular = BehaviorSubject<Products>();
  final _newArrivals = BehaviorSubject<Products>();
  final _sale = BehaviorSubject<Products>();
  final _products = BehaviorSubject<Products>();
  final _scroll = BehaviorSubject<ScrollController>();
  final _loadingMore = BehaviorSubject<bool>();

  int _page;

  User get user => _user.value;

  set user(User value) {
    _user.add(value);
    notifyListeners();
  }

  Products get popular => _popular.value;

  set popular(Products value) {
    _popular.add(value);
    notifyListeners();
  }

  Products get newArrivals => _newArrivals.value;

  set newArrivals(Products value) {
    _newArrivals.add(value);
    notifyListeners();
  }

  Products get products => _products.value;

  set products(Products value) {
    _products.add(value);
    notifyListeners();
  }

  ScrollController get scroll => _scroll.value;

  set scroll(ScrollController value) {
    _scroll.add(value);
    notifyListeners();
  }

  bool get loadingMore => _loadingMore.value;

  set loadingMore(bool value) {
    _loadingMore.add(value);
    notifyListeners();
  }

  Products get sale => _sale.value;

  set sale(Products value) {
    _sale.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    _page = 1;
    scroll = ScrollController()
      ..addListener(() {
        if (scroll.offset >= scroll.position.maxScrollExtent &&
            !scroll.position.outOfRange) {
          loadMore();
        }
      });
    loadingMore = false;
    _user.add(SharedPref.getUser());
    final popularResponse = await productResponse.getPopular(1);
    if (popularResponse.statusCode == 200) {
      popular = Products.fromJson(popularResponse.data);
    }
    final newArrivalsResponse = await productResponse.getNew(1);
    if (newArrivalsResponse.statusCode == 200) {
      newArrivals = Products.fromJson(newArrivalsResponse.data);
    }
    final saleResponse = await productResponse.getSale(1);
    if (saleResponse.statusCode == 200) {
      sale = Products.fromJson(saleResponse.data);
    }
    final productData = await productResponse.getProducts(_page);
    if (productData.statusCode == 200) {
      products = Products.fromJson(productData.data);
    }

    isLoading = false;
  }

  Future loadMore() async {
    final meta = products.meta;
    if (meta.currentPage <= meta.lastPage) {
      _page++;
      loadingMore = true;
      final productData = await productResponse.getProducts(_page);
      loadingMore = false;
      final product = Products.fromJson(productData.data);
      products = products.copyWith(
          data: products.data..addAll(product.data),
          links: product.links,
          meta: product.meta);
    }
  }

  int countCart() {
    return SharedPref.getCarts()?.length ?? 0;
  }

  @override
  Future dispose() async {
    await _user.drain();
    await _user.close();
    await _popular.drain();
    await _popular.close();
    await _newArrivals.drain();
    await _newArrivals.close();
    await _sale.drain();
    await _sale.close();
    await _products.drain();
    await _products.close();
    return super.dispose();
  }
}
