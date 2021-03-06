import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import '../../resources/resources.dart';
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

  Order get pendingOrders => orders.copyWith(
      data: orders.data
          .where((element) => element.status == OrderStatus.pending)
          .toList());

  Order get shippingOrders => orders.copyWith(
      data: orders.data
          .where((element) => element.status == OrderStatus.shipping)
          .toList());

  Order get completedOrders => orders.copyWith(
      data: orders.data
          .where((element) => element.status == OrderStatus.completed)
          .toList());

  Order get cancelledOrders => orders.copyWith(
      data: orders.data
          .where((element) => element.status == OrderStatus.cancelled)
          .toList());

  Future init() async {
    isLoading = true;

    final orderRepo = await repository.getOrders();
    if (orderRepo.statusCode == 200) {
      orders = Order.fromJson(orderRepo.data);
    } else {
      Navigator.pop(context);
    }

    isLoading = false;
  }

  @override
  Future dispose() async {
    await _orders.drain();
    await _orders.close();
    return super.dispose();
  }
}
