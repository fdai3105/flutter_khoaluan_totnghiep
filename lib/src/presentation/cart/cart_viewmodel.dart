import 'package:flutter/cupertino.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/order.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../utils/utils.dart';
import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';
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
    if (carts.isEmpty) return;
    DialogConfirm(
      context: context,
      title: 'Delete ${carts.length} items?',
      onConfirm: () {
        SharedPref.removeCarts();
        init();
      },
    ).show();
  }

  void checkout(String note, int addressID) {
    if (SharedPref.getUser() == null) {
      Navigator.pushNamed(context, Routes.login);
    } else {
      pushNewScreen(
        context,
        screen: CheckoutScreen(carts: carts),
      );
      // final repo = await orderRepository.checkout(
      //     SharedPref.getCarts(), note, addressID);
      // if (repo.statusCode == 200) {
      //   await SharedPref.removeCarts();
      //   Navigator.pop(context);
      // } else {
      //   print(repo.data);
      // }
    }
  }

  @override
  Future dispose() {
    _carts.close();
    return super.dispose();
  }
}
