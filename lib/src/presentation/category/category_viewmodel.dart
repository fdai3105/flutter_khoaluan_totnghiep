import 'package:rxdart/rxdart.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryResponse categoryResponse;
  final ProductResponse productResponse;

  CategoryViewModel({this.categoryResponse, this.productResponse});

  final _subCategory = BehaviorSubject<CategoryResource>();
  final _products = BehaviorSubject<ProductResource>();

  CategoryResource get subCategory => _subCategory.value;

  set subCategory(CategoryResource value) {
    _subCategory.add(value);
    notifyListeners();
  }

  ProductResource get products => _products.value;

  set products(ProductResource value) {
    _products.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final subCate = await categoryResponse.getSubCategories(id);
    if (subCate.statusCode == 200) {
      subCategory = CategoryResource.fromJson(subCate.data);
    }
    final productsRepo = await productResponse.getProductsByParentCategory(id);
    if (productsRepo.statusCode == 200) {
      products = ProductResource.fromJson(productsRepo.data);
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
