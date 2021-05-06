// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import '../../../resources/resources.dart';
import '../../presentation.dart';

class SubCategoryViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  SubCategoryViewModel({this.productResponse});

  final _products = BehaviorSubject<Products>();

  Products get products => _products.value;

  set products(Products value) {
    _products.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final productsRepo = await productResponse.getProductsByCategory(id);
    if (productsRepo.statusCode == 200) {
      products = Products.fromJson(productsRepo.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() async {
    await _products.drain();
    await _products.close();
    return super.dispose();
  }
}
