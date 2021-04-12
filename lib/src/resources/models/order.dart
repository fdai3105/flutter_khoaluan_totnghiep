import 'dart:convert';

import '../resources.dart';

class Order {
  Order({
    this.data,
  });

  final List<OrderDatum> data;

  Order copyWith({
    List<OrderDatum> data,
  }) =>
      Order(
        data: data ?? this.data,
      );

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    data: List<OrderDatum>.from(json["data"].map((x) => OrderDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDatum {
  OrderDatum({
    this.id,
    this.status,
    this.total,
    this.note,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String status;
  final int total;
  final String note;
  final AddressDatum address;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderDatum copyWith({
    int id,
    String status,
    int total,
    String note,
    AddressDatum address,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      OrderDatum(
        id: id ?? this.id,
        status: status ?? this.status,
        total: total ?? this.total,
        note: note ?? this.note,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDatum.fromRawJson(String str) => OrderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
    id: json["id"],
    status: json["status"],
    total: json["total"],
    note: json["note"],
    address: AddressDatum.fromJson(json["address"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "total": total,
    "note": note,
    "address": address.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}