import 'package:flutter/material.dart';
import 'package:khoaluan_totnghiep_mobile/src/presentation/base/base.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/models/models.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/product.dart';
import 'package:rxdart/rxdart.dart';

class SaleViewModel extends BaseViewModel {
  final ProductResponse response;

  SaleViewModel({this.response});

  int _page = 1;

  final _products = BehaviorSubject<Products>();
  final _scroll = BehaviorSubject<ScrollController>();
  final _loadingMore = BehaviorSubject<bool>();

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

  Products get products => _products.value;

  set products(Products value) {
    _products.add(value);
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

    final saleResponse = await response.getSale(1);
    if (saleResponse.statusCode == 200) {
      products = Products.fromJson(saleResponse.data);
    }

    isLoading = false;
  }

  Future loadMore() async {
    final meta = products.meta;
    if (meta.currentPage <= meta.lastPage) {
      _page++;
      loadingMore = true;
      final productData = await response.getSale(_page);
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
    _scroll.close();
    _loadingMore.close();
    return super.dispose();
  }
}
