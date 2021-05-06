import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

class ProductViewModel extends BaseViewModel {
  final ProductResponse response;

  ProductViewModel({this.response});

  final _product = BehaviorSubject<Product>();
  final _similarProducts = BehaviorSubject<Products>();
  final _isFavorite = BehaviorSubject<bool>();

  Product get product => _product.value;

  set product(Product value) {
    _product.add(value);
    notifyListeners();
  }

  Products get similarProducts => _similarProducts.value;

  set similarProducts(Products value) {
    _similarProducts.add(value);
    notifyListeners();
  }

  bool get isFavorite => _isFavorite.value;

  set isFavorite(bool value) {
    _isFavorite.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final productResponse = await response.getProduct(id);
    if (productResponse.statusCode == 200) {
      product = Product.fromJson(productResponse.data);
    }
    final similarResponse = await response.getSimilarProducts(id);
    if (similarResponse.statusCode == 200) {
      similarProducts = Products.fromJson(similarResponse.data);
    }
    checkFavorite();

    isLoading = false;
  }

  void addToCart(int quantity, ProductDatum product) {
    SharedPref.addCart(Cart(quantity: quantity, product: product));
    DialogAddCart(context: context).show();
  }

  void checkFavorite() {
    if (SharedPref.getFavorites()
            .where((element) => element.id == product.data.id).isEmpty) {
      isFavorite = false;
    } else {
      isFavorite = true;
    }
  }

  void favorite() {
    SharedPref.addToFavorite(product.data);
    checkFavorite();
  }

  @override
  Future dispose() async {
    await _product.drain();
    await _product.close();
    await _similarProducts.drain();
    await _similarProducts.close();

    return super.dispose();
  }
}
