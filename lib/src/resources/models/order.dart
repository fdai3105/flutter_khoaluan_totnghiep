// // import 'dart:convert';
// //
// // import '../resources.dart';
// //
// // class Order {
// //   Order({
// //     this.data,
// //   });
// //
// //   final List<OrderDatum> data;
// //
// //   Order copyWith({
// //     List<OrderDatum> data,
// //   }) =>
// //       Order(
// //         data: data ?? this.data,
// //       );
// //
// //   factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));
// //
// //   String toRawJson() => json.encode(toJson());
// //
// //   factory Order.fromJson(Map<String, dynamic> json) => Order(
// //         data: List<OrderDatum>.from(
// //             json["data"].map((x) => OrderDatum.fromJson(x))),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //       };
// // }
// //
// // class OrderDatum {
// //   OrderDatum({
// //     this.id,
// //     this.status,
// //     this.total,
// //     this.note,
// //     this.item,
// //     this.address,
// //     this.createdAt,
// //     this.updatedAt,
// //   });
// //
// //   final int id;
// //   final String status;
// //   final int total;
// //   final String note;
// //   final int item;
// //   final AddressDatum address;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;
// //
// //   OrderDatum copyWith({
// //     int id,
// //     String status,
// //     int total,
// //     String note,
// //     int item,
// //     AddressDatum address,
// //     DateTime createdAt,
// //     DateTime updatedAt,
// //   }) =>
// //       OrderDatum(
// //         id: id ?? this.id,
// //         status: status ?? this.status,
// //         total: total ?? this.total,
// //         note: note ?? this.note,
// //         item: item ?? this.item,
// //         address: address ?? this.address,
// //         createdAt: createdAt ?? this.createdAt,
// //         updatedAt: updatedAt ?? this.updatedAt,
// //       );
// //
// //   factory OrderDatum.fromRawJson(String str) =>
// //       OrderDatum.fromJson(json.decode(str));
// //
// //   String toRawJson() => json.encode(toJson());
// //
// //   factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
// //         id: json["id"],
// //         status: json["status"],
// //         total: json["total"],
// //         note: json["note"],
// //         item: json["item"],
// //         address: AddressDatum.fromJson(json["address"]),
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "status": status,
// //         "total": total,
// //         "note": note,
// //         "item": item,
// //         "address": address.toJson(),
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //       };
// // }
//
// import 'dart:convert';
//
// import '../resources.dart';
//
// class Order {
//   Order({
//     this.data,
//   });
//
//   final List<OrderDatum> data;
//
//   Order copyWith({
//     List<OrderDatum> data,
//   }) =>
//       Order(
//         data: data ?? this.data,
//       );
//
//   factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         data: List<OrderDatum>.from(
//             json["data"].map((x) => OrderDatum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }
//
// class OrderDatum {
//   OrderDatum({
//     this.id,
//     this.status,
//     this.total,
//     this.note,
//     this.item,
//     this.address,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   final int id;
//   final Status status;
//   final int total;
//   final String note;
//   final int item;
//   final AddressDatum address;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   OrderDatum copyWith({
//     int id,
//     Status status,
//     int total,
//     String note,
//     int item,
//     AddressDatum address,
//     DateTime createdAt,
//     DateTime updatedAt,
//   }) =>
//       OrderDatum(
//         id: id ?? this.id,
//         status: status ?? this.status,
//         total: total ?? this.total,
//         note: note ?? this.note,
//         item: item ?? this.item,
//         address: address ?? this.address,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory OrderDatum.fromRawJson(String str) =>
//       OrderDatum.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
//         id: json["id"],
//         status: statusValues.map[json["status"]],
//         total: json["total"],
//         note: json["note"],
//         item: json["item"],
//         address: AddressDatum.fromJson(json["address"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": statusValues.reverse[status],
//         "total": total,
//         "note": note,
//         "item": item,
//         "address": address.toJson(),
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
//
// enum Status {
//   pending,
//   toReceive,
//   completed,
//   cancelled,
// }
//
// final statusValues = EnumValues({
//   "Pending": Status.pending,
//   "To Receive": Status.toReceive,
//   "Completed": Status.completed,
//   "cancelled": Status.cancelled,
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

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
        data: List<OrderDatum>.from(
            json["data"].map((x) => OrderDatum.fromJson(x))),
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
    this.item,
    this.address,
    this.orderDetail,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final OrderStatus status;
  final int total;
  final String note;
  final int item;
  final AddressDatum address;
  final List<OrderDetail> orderDetail;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderDatum copyWith({
    int id,
    OrderStatus status,
    int total,
    String note,
    int item,
    AddressDatum address,
    List<OrderDetail> orderDetail,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      OrderDatum(
        id: id ?? this.id,
        status: status ?? this.status,
        total: total ?? this.total,
        note: note ?? this.note,
        item: item ?? this.item,
        address: address ?? this.address,
        orderDetail: orderDetail ?? this.orderDetail,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDatum.fromRawJson(String str) =>
      OrderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        id: json["id"],
        status: statusValues.map[json["status"]],
        total: json["total"],
        note: json["note"],
        item: json["item"],
        address: AddressDatum.fromJson(json["address"]),
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": statusValues.reverse[status],
        "total": total,
        "note": note,
        "item": item,
        "address": address.toJson(),
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum OrderStatus {
  pending,
  shipping,
  completed,
  cancelled,
}

final statusValues = EnumValues({
  "Pending": OrderStatus.pending,
  "Shipping": OrderStatus.shipping,
  "Completed": OrderStatus.completed,
  "Cancelled": OrderStatus.cancelled,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class OrderDetail {
  OrderDetail({
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
  final ProductDatum product;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderDetail copyWith({
    int id,
    int quantity,
    int total,
    ProductDatum product,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        product: product ?? this.product,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderDetail.fromRawJson(String str) =>
      OrderDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        quantity: json["quantity"],
        total: json["total"],
        product: ProductDatum.fromJson(json["product"]),
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
