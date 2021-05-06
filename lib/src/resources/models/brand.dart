// Dart imports:
import 'dart:convert';

class Brands {
  Brands({
    this.data,
  });

  final List<BrandDatum> data;

  Brands copyWith({
    List<BrandDatum> data,
  }) =>
      Brands(
        data: data ?? this.data,
      );

  factory Brands.fromRawJson(String str) => Brands.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
    data: List<BrandDatum>.from(json["data"].map((x) => BrandDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BrandDatum {
  BrandDatum({
    this.id,
    this.name,
    this.image,
    this.desc,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String image;
  final dynamic desc;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BrandDatum.fromRawJson(String str) => BrandDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandDatum.fromJson(Map<String, dynamic> json) => BrandDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    desc: json["desc"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "desc": desc,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
