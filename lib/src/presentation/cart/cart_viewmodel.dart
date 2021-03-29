import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';

import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';

import '../presentation.dart';

class CartViewModel extends BaseViewModel {
  final _carts = BehaviorSubject<List<Cart>>();

  List<Cart> get carts => _carts.value;

  set carts(List<Cart> value) {
    _carts.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    carts = SharedPref.getCarts();

    isLoading = false;
  }

  void increase(Cart cart) {
    SharedPref.increaseCart(cart);
    init();
  }

  void decrease(Cart cart) {
    SharedPref.decreaseCart(cart);
    init();
  }

  @override
  Future dispose() {
    _carts.close();
    return super.dispose();
  }
}
