// Dart imports:
import 'dart:convert';

// Project imports:
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
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int rating;
  final String comment;
  final UserDatum user;
  final DateTime createdAt;
  final DateTime updatedAt;

  RatingDatum copyWith({
    int id,
    int rating,
    String comment,
    UserDatum user,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      RatingDatum(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RatingDatum.fromRawJson(String str) =>
      RatingDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RatingDatum.fromJson(Map<String, dynamic> json) => RatingDatum(
        id: json["id"],
        rating: json["rating"],
        comment: json["comment"],
        user: UserDatum.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "comment": comment,
        "user": user.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
