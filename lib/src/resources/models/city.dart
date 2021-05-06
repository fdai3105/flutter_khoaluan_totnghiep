import 'dart:convert';

class City {
  City({
    this.name,
    this.slug,
    this.type,
    this.nameWithType,
    this.code,
  });

  final String name;
  final String slug;
  final String type;
  final String nameWithType;
  final String code;

  City copyWith({
    String name,
    String slug,
    String type,
    String nameWithType,
    String code,
  }) =>
      City(
        name: name ?? this.name,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        nameWithType: nameWithType ?? this.nameWithType,
        code: code ?? this.code,
      );

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
    name: json["name"],
    slug: json["slug"],
    type: json["type"],
    nameWithType: json["name_with_type"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "type": type,
    "name_with_type": nameWithType,
    "code": code,
  };

  @override
  String toString() {
    return 'City{name: $name, slug: $slug, type: $type, nameWithType: $nameWithType, code: $code}';
  }
}
