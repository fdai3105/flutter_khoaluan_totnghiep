import 'dart:convert';

import '../resources.dart';

class ProductPagination {
  ProductPagination({
    this.data,
    this.links,
    this.meta,
  });

  final List<Product> data;
  final Links links;
  final Meta meta;

  ProductPagination copyWith({
    List<Product> data,
    Links links,
    Meta meta,
  }) =>
      ProductPagination(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory ProductPagination.fromRawJson(String str) => ProductPagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductPagination.fromJson(Map<String, dynamic> json) => ProductPagination(
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.desc,
    this.brand,
    this.category,
    this.images,
    this.attributes,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final int price;
  final String desc;
  final Brand brand;
  final Brand category;
  final List<ProductImage> images;
  final List<Attribute> attributes;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    desc: json["desc"],
    brand: Brand.fromJson(json["brand"]),
    category: Brand.fromJson(json["category"]),
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "desc": desc,
    "brand": brand.toJson(),
    "category": category.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
