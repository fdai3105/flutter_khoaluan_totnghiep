import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../presentation.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryResponse categoryResponse;
  final ProductResponse productResponse;

  CategoryViewModel({this.categoryResponse, this.productResponse});

  final _subCategory = BehaviorSubject<Category>();
  final _products = BehaviorSubject<Products>();

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

  Future init(int id) async {
    isLoading = true;

    final subCate = await categoryResponse.getSubCategories(id);
    if (subCate.statusCode == 200) {
      subCategory = Category.fromJson(subCate.data);
    }
    final productsRepo = await productResponse.getProductsByParentCategory(id);
    if (productsRepo.statusCode == 200) {
      products = Products.fromJson(productsRepo.data);
    }

    isLoading = false;
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
