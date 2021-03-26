import 'package:rxdart/rxdart.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

class SubCategoryViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  SubCategoryViewModel({this.productResponse});

  final _products = BehaviorSubject<ProductResource>();

  ProductResource get products => _products.value;

  set products(ProductResource value) {
    _products.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final productsRepo = await productResponse.getProductsByCategory(id);
    if (productsRepo.statusCode == 200) {
      products = ProductResource.fromJson(productsRepo.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _products.close();
    return super.dispose();
  }
}
