import 'package:flutter/cupertino.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
import '../../utils/utils.dart';
import '../presentation.dart';

class CartViewModel extends BaseViewModel {
  final OrderRepository orderRepository;

  CartViewModel({this.orderRepository});

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

  void removeCart(Cart cart) {
    DialogConfirm(
      context: context,
      title: 'Delete "${cart.product.name}" from cart?',
      onConfirm: () {
        SharedPref.removeCart(cart);
        init();
      },
    ).show();
  }

  void clearCart() {
    if (carts.isEmpty) {
      return;
    }
    DialogConfirm(
      context: context,
      title: 'Delete ${carts.length} items?',
      onConfirm: () {
        SharedPref.removeCarts();
        init();
      },
    ).show();
  }

  Future checkout() async {
    final dl = DialogLoading.of(context)..show();
    final isVerified = await AuthRepository.hasVerifiedEmail();
    dl.hide();

    if (SharedPref.getUser() == null) {
      await Navigator.pushNamed(context, Routes.login);
    } else {
      await pushNewScreen(
        context,
        screen: isVerified ? CheckoutScreen(carts: carts) : ResendMailScreen(),
      );
    }
  }

  @override
  Future dispose() {
    _carts.close();
    return super.dispose();
  }
}
