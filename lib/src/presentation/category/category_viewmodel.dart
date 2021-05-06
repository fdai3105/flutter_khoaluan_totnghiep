import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../presentation.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryResponse response;
  final ProductResponse productResponse;

  CategoryViewModel({this.response, this.productResponse});

  final _subCategory = BehaviorSubject<Category>();
  final _products = BehaviorSubject<Products>();

  int _page = 1;

  final _scroll = BehaviorSubject<ScrollController>();
  final _loadingMore = BehaviorSubject<bool>();

  Category get subCategory => _subCategory.value;

  set subCategory(Category value) {
    _subCategory.add(value);
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

  Future init(int id) async {
    isLoading = true;

    scroll = ScrollController()
      ..addListener(() {
        if (scroll.offset >= scroll.position.maxScrollExtent &&
            !scroll.position.outOfRange) {
          loadMore(id);
        }
      });
    loadingMore = false;

    final subCate = await response.getSubCategories(id);
    if (subCate.statusCode == 200) {
      subCategory = Category.fromJson(subCate.data);
    }
    final productsRepo =
        await productResponse.getProductsByParentCategory(id, _page);
    if (productsRepo.statusCode == 200) {
      products = Products.fromJson(productsRepo.data);
    }

    isLoading = false;
  }

  Future loadMore(int parentID) async {
    final meta = products.meta;
    if (meta.currentPage <= meta.lastPage) {
      _page++;
      loadingMore = true;
      final productData =
          await productResponse.getProductsByParentCategory(parentID, _page);
      loadingMore = false;
      final product = Products.fromJson(productData.data);
      products = products.copyWith(
          data: products.data..addAll(product.data),
          links: product.links,
          meta: product.meta);
    }
  }

  @override
  Future dispose() async {
    await _subCategory.drain();
    await _subCategory.close();
    await _products.drain();
    await _products.close();
    return super.dispose();
  }
}
