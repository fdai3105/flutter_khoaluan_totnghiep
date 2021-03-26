import 'dart:convert';

class CategoryResource {
  CategoryResource({
    this.data,
  });

  final List<Category> data;

  CategoryResource copyWith({
    List<Category> data,
  }) =>
      CategoryResource(
        data: data ?? this.data,
      );

  factory CategoryResource.fromRawJson(String str) =>
      CategoryResource.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryResource.fromJson(Map<String, dynamic> json) =>
      CategoryResource(
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  Category({
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

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
