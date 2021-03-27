import 'package:rxdart/rxdart.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryResponse categoryResponse;
  final ProductResponse productResponse;

  CategoryViewModel({this.categoryResponse, this.productResponse});

  final _subCategory = BehaviorSubject<Categories>();
  final _products = BehaviorSubject<Products>();

  Categories get subCategory => _subCategory.value;

  set subCategory(Categories value) {
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
      subCategory = Categories.fromJson(subCate.data);
    }
    final productsRepo = await productResponse.getProductsByParentCategory(id);
    if (productsRepo.statusCode == 200) {
      products = Products.fromJson(productsRepo.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _subCategory.close();
    _products.close();
    return super.dispose();
  }
}
