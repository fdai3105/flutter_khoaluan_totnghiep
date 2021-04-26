import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class OrderDetailViewModel extends BaseViewModel {
  final OrderRepository repository;

  OrderDetailViewModel({@required this.repository});

  final _orderDetail = BehaviorSubject<OrderDetail>();

  OrderDetail get orderDetail => _orderDetail.value;

  set orderDetail(OrderDetail value) {
    _orderDetail.add(value);
    notifyListeners();
  }

  Future init() async {
    isLoading = true;

    isLoading = false;
  }

  bool isCanCancel(OrderDatum order) {
    final time =
        DateTime.now().difference(order.createdAt) < const Duration(hours: 6);
    if (time && order.status == OrderStatus.pending) {
      return true;
    }
    return false;
  }

  Future cancelOrder(int id) async {
    final rs = await repository.cancelOrder(id);
    if (rs.statusCode == 200) {
      Navigator.pop(context);
    } else {
      print(rs.data);
    }
  }

  @override
  Future dispose() {
    _orderDetail.close();
    return super.dispose();
  }
}
