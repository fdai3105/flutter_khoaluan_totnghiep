import 'dart:convert';

class BrandResource {
  BrandResource({
    this.data,
  });

  final List<Brand> data;

  BrandResource copyWith({
    List<Brand> data,
  }) =>
      BrandResource(
        data: data ?? this.data,
      );

  factory BrandResource.fromRawJson(String str) => BrandResource.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandResource.fromJson(Map<String, dynamic> json) => BrandResource(
    data: List<Brand>.from(json["data"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Brand {
  Brand({
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

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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