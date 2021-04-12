import 'package:flutter/foundation.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/order.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/resources.dart';
import 'package:rxdart/rxdart.dart';

import '../presentation.dart';

class OrderViewModel extends BaseViewModel {
  final OrderRepository repository;

  OrderViewModel({@required this.repository});

  final _orders = BehaviorSubject<Order>();

  Order get orders => _orders.value;

  set orders(Order value) {
    _orders.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    final orderRepo = await repository.getOrders();
    if (orderRepo.statusCode == 200) {
      orders = Order.fromJson(orderRepo.data);
    }

    isLoading = false;
  }

  @override
  Future dispose() {
    _orders.close();
    return super.dispose();
  }
}
