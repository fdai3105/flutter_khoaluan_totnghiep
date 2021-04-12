import 'dart:convert';

import '../resources.dart';

class OrderDetail {
  OrderDetail({
    this.data,
  });

  final List<OrderDetailDatum> data;

  OrderDetail copyWith({
    List<OrderDetailDatum> data,
  }) =>
      OrderDetail(
        data: data ?? this.data,
      );

  factory OrderDetail.fromRawJson(String str) => OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    data: List<OrderDetailDatum>.from(json["data"].map((x) => OrderDetailDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDetailDatum {
  OrderDetailDatum({
    this.id,
    this.quantity,
    this.total,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int quantity;
  final int total;
  final Product product;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderDetailDatum copyWith({
    int id,
    int quantity,
    int total,
    Product product,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      OrderDetailDatum(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        product: product ?? this.product,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDetailDatum.fromRawJson(String str) => OrderDetailDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailDatum.fromJson(Map<String, dynamic> json) => OrderDetailDatum(
    id: json["id"],
    quantity: json["quantity"],
    total: json["total"],
    product: Product.fromJson(json["product"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "total": total,
    "product": product.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
