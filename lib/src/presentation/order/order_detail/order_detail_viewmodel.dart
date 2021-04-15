import 'package:rxdart/rxdart.dart';
import '../../../resources/resources.dart';
import '../../presentation.dart';

class OrderDetailViewModel extends BaseViewModel {
  final OrderRepository repository;

  OrderDetailViewModel({this.repository});

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

  @override
  Future dispose() {
    _orderDetail.close();
    return super.dispose();
  }
}
