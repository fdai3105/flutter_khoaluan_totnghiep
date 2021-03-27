import 'dart:convert';

import '../resources.dart';

class Ratings {
  Ratings({
    this.data,
  });

  final List<RatingDatum> data;

  Ratings copyWith({
    List<RatingDatum> data,
  }) =>
      Ratings(
        data: data ?? this.data,
      );

  factory Ratings.fromRawJson(String str) => Ratings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        data: List<RatingDatum>.from(
            json["data"].map((x) => RatingDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RatingDatum {
  RatingDatum({
    this.id,
    this.rating,
    this.comment,
    this.user,
  });

  final int id;
  final int rating;
  final String comment;
  final UserDatum user;

  RatingDatum copyWith({
    int id,
    int rating,
    String comment,
    UserDatum user,
  }) =>
      RatingDatum(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        user: user ?? this.user,
      );

  factory RatingDatum.fromRawJson(String str) =>
      RatingDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingDatum.fromJson(Map<String, dynamic> json) => RatingDatum(
        id: json["id"],
        rating: json["rating"],
        comment: json["comment"],
        user: UserDatum.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "comment": comment,
        "user": user.toJson(),
      };
}
