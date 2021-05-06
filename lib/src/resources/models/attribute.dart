// Dart imports:
import 'dart:convert';

class Attribute {
  Attribute({
    this.id,
    this.attribute,
    this.attributeType,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String attribute;
  final AttributeType attributeType;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Attribute.fromRawJson(String str) =>
      Attribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        attribute: json["attribute"],
        attributeType: AttributeType.fromJson(json["attribute_type"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attribute": attribute,
        "attribute_type": attributeType.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class AttributeType {
  AttributeType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AttributeType.fromRawJson(String str) =>
      AttributeType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttributeType.fromJson(Map<String, dynamic> json) => AttributeType(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
