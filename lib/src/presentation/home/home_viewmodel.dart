import 'package:flutter/cupertino.dart';
import '../../resources/repositories/product.dart';
import '../../resources/resources.dart';
import '../../utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';
import '../presentation.dart';

class HomeViewModel extends BaseViewModel {
  final AuthRepository authRepository;
  final ProductResponse productResponse;

  HomeViewModel({
    @required this.authRepository,
    @required this.productResponse,
  });

  final _user = BehaviorSubject<User>();
  final _popular = BehaviorSubject<ProductPagination>();
  final _newArrivals = BehaviorSubject<ProductPagination>();
  final _products = BehaviorSubject<ProductPagination>();

  User get user => _user.value;

  set user(User value) {
    _user.add(value);
  }

  ProductPagination get popular => _popular.value;

  set popular(ProductPagination value) {
    _popular.add(value);
  }

  ProductPagination get newArrivals => _newArrivals.value;

  set newArrivals(ProductPagination value) {
    _newArrivals.add(value);
  }

  ProductPagination get products => _products.value;

  set products(ProductPagination value) {
    _products.add(value);
  }

  Future init() async {
    isLoading = true;

    _user.add(SharedPref.getUser());
    final popularResponse = await productResponse.getPopular();
    if (popularResponse.statusCode == 200) {
      popular = ProductPagination.fromJson(popularResponse.data);
    }
    final newArrivalsResponse = await productResponse.getNew();
    if (newArrivalsResponse.statusCode == 200) {
      newArrivals = ProductPagination.fromJson(newArrivalsResponse.data);
    }
    final productData = await productResponse.getProducts();
    if (productData.statusCode == 200) {
      products = ProductPagination.fromJson(productData.data);
    }

    isLoading = false;
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
