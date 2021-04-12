import 'package:flutter/foundation.dart';
import 'package:khoaluan_totnghiep_mobile/src/resources/repositories/order.dart';
import 'package:rxdart/rxdart.dart';

import '../presentation.dart';

class OrderViewModel extends BaseViewModel {
  final OrderRepository repository;

  OrderViewModel({@required this.repository});

  final _orders = BehaviorSubject();

  Future init() async {
    isLoading = true;



    isLoading = false;
  }
}
