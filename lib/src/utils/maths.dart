// Project imports:
import '../resources/resources.dart';

class Maths {
  Maths._();

  static  int calTotalCart(List<Cart> carts) {
    var total = 0;

    if (carts.isEmpty) {
      return 0;
    }

    carts.forEach((element) {
      total += element.product.price * element.quantity;
    });

    return total;
  }

}
