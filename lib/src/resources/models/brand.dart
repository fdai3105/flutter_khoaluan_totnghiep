import 'dart:convert';

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