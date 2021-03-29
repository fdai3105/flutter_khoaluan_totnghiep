import 'package:khoaluan_totnghiep_mobile/src/utils/shared_pref.dart';

import '../../resources/resources.dart';
import 'package:rxdart/rxdart.dart';

import '../presentation.dart';

class ProductViewModel extends BaseViewModel {
  final ProductResponse productResponse;

  ProductViewModel({this.productResponse});

  final _product = BehaviorSubject<Product>();

  Product get product => _product.value;

  set product(Product value) {
    _product.add(value);
    notifyListeners();
  }

  Future init(int id) async {
    isLoading = true;

    final pro = await productResponse.getProduct(id);
    if (pro.statusCode == 200) {
      product = Product.fromJson(pro.data);
    }

    isLoading = false;
  }

  void addToCart(Cart cart) {
    SharedPref.addCart(cart);
  }

  @override
  Future dispose() {
    _product.close();
    return super.dispose();
  }
}
