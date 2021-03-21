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

  User get user => _user.value;

  ProductPagination get popular => _popular.value;

  ProductPagination get newArrivals => _newArrivals.value;

  Future init() async {
    isLoading = true;

    _user.add(SharedPref.getUser());
    final popular = await productResponse.getPopular();
    if (popular.statusCode == 200) {
      _popular.add(ProductPagination.fromJson(popular.data));
    }
    final newArrivalsResponse = await productResponse.getNew();
    if (newArrivalsResponse.statusCode == 200) {
      _newArrivals.add(ProductPagination.fromJson(newArrivalsResponse.data));
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _user.close();
    _popular.close();
    _newArrivals.close();
    return super.dispose();
  }
}
