import 'dart:convert';

import 'models.dart';

class Cart {
   int quantity;
  final ProductDatum product;

  Cart({
    this.quantity,
    this.product,
  });

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "product": product.toJson(),
      };

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      quantity: json["quantity"],
      product: ProductDatum.fromJson(json["product"]));

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Cart copyWith({
    int quantity,
    ProductDatum product,
  }) =>
      Cart(
        quantity: quantity ?? this.quantity,
        product: product ?? this.product,
      );

  @override
  String toString() {
    return 'Cart{quantity: $quantity, product: $product}';
  }
}
