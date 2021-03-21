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

  User get user => _user.value;

  ProductPagination get popular => _popular.value;

  Future init() async {
    isLoading = true;
    _user.add(SharedPref.getUser());

    final popular = await ProductResponse().getPopular();
    if (popular.statusCode == 200) {
      print(popular.data);
      _popular.add(ProductPagination.fromJson(popular.data));
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _user.close();
    _popular.close();
    return super.dispose();
  }
}
