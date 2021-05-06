// Dart imports:
import 'dart:convert';

class District {
  District({
    this.name,
    this.type,
    this.slug,
    this.nameWithType,
    this.path,
    this.pathWithType,
    this.code,
    this.parentCode,
  });

  final String name;
  final String type;
  final String slug;
  final String nameWithType;
  final String path;
  final String pathWithType;
  final String code;
  final String parentCode;

  District copyWith({
    String name,
    String type,
    String slug,
    String nameWithType,
    String path,
    String pathWithType,
    String code,
    String parentCode,
  }) =>
      District(
        name: name ?? this.name,
        type: type ?? this.type,
        slug: slug ?? this.slug,
        nameWithType: nameWithType ?? this.nameWithType,
        path: path ?? this.path,
        pathWithType: pathWithType ?? this.pathWithType,
        code: code ?? this.code,
        parentCode: parentCode ?? this.parentCode,
      );

  factory District.fromRawJson(String str) => District.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory District.fromJson(Map<String, dynamic> json) => District(
    name: json["name"],
    type: json["type"],
    slug: json["slug"],
    nameWithType: json["name_with_type"],
    path: json["path"],
    pathWithType: json["path_with_type"],
    code: json["code"],
    parentCode: json["parent_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "slug": slug,
    "name_with_type": nameWithType,
    "path": path,
    "path_with_type": pathWithType,
    "code": code,
    "parent_code": parentCode,
  };
}
