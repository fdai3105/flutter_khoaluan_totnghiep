import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../presentation.dart';

class NewProductViewModel extends BaseViewModel {
  final ProductResponse response;

  NewProductViewModel({@required this.response});

  int _page = 1;

  final _products = BehaviorSubject<Products>();
  final _scroll = BehaviorSubject<ScrollController>();
  final _loadingMore = BehaviorSubject<bool>();

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

    final newResponse = await response.getNew(1);
    if(newResponse.statusCode == 200) {
      products = Products.fromJson(newResponse.data);
    }

    isLoading = false;
  }

  Future loadMore() async {
    final meta = products.meta;
    if (meta.currentPage <= meta.lastPage) {
      _page++;
      loadingMore = true;
      final productData = await response.getNew(_page);
      loadingMore = false;
      final product = Products.fromJson(productData.data);
      products = products.copyWith(
          data: products.data..addAll(product.data),
          links: product.links,
          meta: product.meta);
    }
  }

  @override
  Future dispose() {
    _products.close();
    return super.dispose();
  }
}
