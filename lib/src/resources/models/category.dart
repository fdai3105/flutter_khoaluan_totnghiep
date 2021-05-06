// Dart imports:
import 'dart:convert';

class Category {
  Category({
    this.data,
  });

  final List<CategoryDatum> data;

  Category copyWith({
    List<CategoryDatum> data,
  }) =>
      Category(
        data: data ?? this.data,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(
        data:
            List<CategoryDatum>.from(json["data"].map((x) => CategoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoryDatum {
  CategoryDatum({
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

  factory CategoryDatum.fromRawJson(String str) =>
      CategoryDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
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
        'image': image,
        "desc": desc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
