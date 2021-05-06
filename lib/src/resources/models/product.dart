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

  factory Products.fromRawJson(String str) =>
      Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: List<ProductDatum>.from(
            json["data"].map((x) => ProductDatum.fromJson(x))),
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
  final int id;
  final String name;
  final int price;
  final String desc;
  final int stock;
  final int bought;
  final int warranty;
  final int discount;
  final int rating;
  final double ratingAveraged;
  final BrandDatum brand;
  final CategoryDatum category;
  final List<ProductImage> images;
  final List<Attribute> attributes;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductDatum({
    this.id,
    this.name,
    this.price,
    this.desc,
    this.stock,
    this.bought,
    this.warranty,
    this.discount,
    this.rating,
    this.ratingAveraged,
    this.brand,
    this.category,
    this.images,
    this.attributes,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDatum.fromRawJson(String str) =>
      ProductDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        desc: json["desc"],
        stock: json["stock"],
        bought: json["bought"],
        warranty: json["warranty"],
        discount: json["discount"],
        rating: json["rating"],
        ratingAveraged: json["rating_averaged"] is int
            ? double.parse(json["rating_averaged"].toString())
            : json["rating_averaged"],
        brand: BrandDatum.fromJson(json["brand"]),
        category: CategoryDatum.fromJson(json["category"]),
        images: List<ProductImage>.from(
            json["images"].map((x) => ProductImage.fromJson(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "desc": desc,
        "stock": stock,
        "bought": bought,
        "warranty": warranty,
        "discount": discount,
        "rating": rating,
        "rating_averaged": ratingAveraged,
        "brand": brand.toJson(),
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
