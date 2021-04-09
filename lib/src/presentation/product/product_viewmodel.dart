import 'package:rxdart/rxdart.dart';
import '../../utils/utils.dart';
import '../presentation.dart';
import '../../resources/resources.dart';

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

  void addToCart(int quantity, ProductDatum product) {
    SharedPref.addCart(Cart(quantity: quantity, product: product));
    DialogAddCart(context: context).show();
  }

  @override
  Future dispose() {
    _product.close();
    return super.dispose();
  }
}
