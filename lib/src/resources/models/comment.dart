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

  factory Comments.fromRawJson(String str) => Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    data: List<CommentDatum>.from(json["data"].map((x) => CommentDatum.fromJson(x))),
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
  });

  final int id;
  final String comment;
  final UserDatum user;

  CommentDatum copyWith({
    int id,
    String comment,
    User user,
  }) =>
      CommentDatum(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        user: user ?? this.user,
      );

  factory CommentDatum.fromRawJson(String str) => CommentDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
    id: json["id"],
    comment: json["comment"],
    user: UserDatum.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "user": user.toJson(),
  };
}