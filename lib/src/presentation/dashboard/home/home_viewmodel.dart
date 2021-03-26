import 'package:flutter/cupertino.dart';
import '../../../resources/repositories/product.dart';
import '../../../resources/resources.dart';
import '../../../utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';
import '../../presentation.dart';

class HomeViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final ProductResponse productResponse;

  HomeViewModel({
    @required this.authRepository,
    @required this.productResponse,
  });

  final _user = BehaviorSubject<User>();
  final _popular = BehaviorSubject<ProductResource>();
  final _newArrivals = BehaviorSubject<ProductResource>();
  final _products = BehaviorSubject<ProductResource>();
  final _scroll = BehaviorSubject<ScrollController>();
  final _loadingMore = BehaviorSubject<bool>();

  int _page = 1;

  User get user => _user.value;

  set user(User value) {
    _user.add(value);
    notifyListeners();
  }

  ProductResource get popular => _popular.value;

  set popular(ProductResource value) {
    _popular.add(value);
    notifyListeners();
  }

  ProductResource get newArrivals => _newArrivals.value;

  set newArrivals(ProductResource value) {
    _newArrivals.add(value);
    notifyListeners();
  }

  ProductResource get products => _products.value;

  set products(ProductResource value) {
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

  Future init() async {
    isLoading = true;

    scroll = ScrollController()
      ..addListener(() {
        if (scroll.offset >= scroll.position.maxScrollExtent &&
            !scroll.position.outOfRange) {
          loadMore();
        }
      });
    loadingMore = false;
    _user.add(SharedPref.getUser());
    final popularResponse = await productResponse.getPopular();
    if (popularResponse.statusCode == 200) {
      popular = ProductResource.fromJson(popularResponse.data);
    }
    final newArrivalsResponse = await productResponse.getNew();
    if (newArrivalsResponse.statusCode == 200) {
      newArrivals = ProductResource.fromJson(newArrivalsResponse.data);
    }
    final productData = await productResponse.getProducts(_page);
    if (productData.statusCode == 200) {
      products = ProductResource.fromJson(productData.data);
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
      final product = ProductResource.fromJson(productData.data);
      products = products.copyWith(
          data: products.data..addAll(product.data),
          links: product.links,
          meta: product.meta);
    }
  }

  @override
  Future dispose() {
    _user.close();
    _popular.close();
    _newArrivals.close();
    _products.close();
    return super.dispose();
  }
}
