import 'dart:convert';

class Address {
  Address({
    this.data,
  });

  final List<AddressDatum> data;

  Address copyWith({
    List<AddressDatum> data,
  }) =>
      Address(
        data: data ?? this.data,
      );

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    data: List<AddressDatum>.from(json["data"].map((x) => AddressDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AddressDatum {
  AddressDatum({
    this.id,
    this.city,
    this.district,
    this.ward,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String city;
  final String district;
  final String ward;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressDatum copyWith({
    int id,
    String city,
    String district,
    String ward,
    String address,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      AddressDatum(
        id: id ?? this.id,
        city: city ?? this.city,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AddressDatum.fromRawJson(String str) => AddressDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressDatum.fromJson(Map<String, dynamic> json) => AddressDatum(
    id: json["id"],
    city: json["city"],
    district: json["district"],
    ward: json["ward"],
    address: json["address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "district": district,
    "ward": ward,
    "address": address,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
