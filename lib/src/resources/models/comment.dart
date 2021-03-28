import 'dart:convert';

import '../resources.dart';

class Comments {
  Comments({
    this.data,
  });

  final List<CommentDatum> data;

  Comments copyWith({
    List<CommentDatum> data,
  }) =>
      Comments(
        data: data ?? this.data,
      );

  factory Comments.fromRawJson(String str) =>
      Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        data: List<CommentDatum>.from(
            json["data"].map((x) => CommentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CommentDatum {
  CommentDatum({
    this.id,
    this.comment,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String comment;
  final UserDatum user;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentDatum copyWith({
    int id,
    String comment,
    User user,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      CommentDatum(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CommentDatum.fromRawJson(String str) =>
      CommentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        id: json["id"],
        comment: json["comment"],
        user: UserDatum.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "user": user.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
