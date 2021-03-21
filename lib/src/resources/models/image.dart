import 'dart:convert';

class Image {
  Image({
    this.id,
    this.name,
    this.image,
    this.desc,
    this.createdAt,
    this.updatedAt,
    this.productId,
  });

  final int id;
  final String name;
  final String image;
  final dynamic desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productId;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));



  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        desc: json["desc"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "desc": desc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_id": productId,
      };
}
