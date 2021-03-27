import 'dart:convert';

import '../resources.dart';

class Products {
  Products({
    this.data,
    this.links,
    this.meta,
  });

  final List<ProductDatum> data;
  final Links links;
  final Meta meta;

  Products copyWith({
    List<ProductDatum> data,
    Links links,
    Meta meta,
  }) =>
      Products(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    data: List<ProductDatum>.from(json["data"].map((x) => ProductDatum.fromJson(x))),
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
    this.data,
  });

  final ProductDatum data;

  Product copyWith({
    ProductDatum data,
  }) =>
      Product(
        data: data ?? this.data,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    data: ProductDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class ProductDatum {
  ProductDatum({
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
  final BrandDatum brand;
  final BrandDatum category;
  final List<ProductImage> images;
  final List<Attribute> attributes;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ProductDatum.fromRawJson(String str) => ProductDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    desc: json["desc"],
    brand: BrandDatum.fromJson(json["brand"]),
    category: BrandDatum.fromJson(json["category"]),
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
