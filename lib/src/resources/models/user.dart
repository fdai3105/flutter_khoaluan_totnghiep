import 'dart:convert';

class User {
  User({
    this.user,
    this.accessToken,
    this.expiresAt,
  });

  final UserDatum user;
  final String accessToken;
  final DateTime expiresAt;

  User copyWith({
    UserDatum user,
    String accessToken,
    DateTime expiresAt,
  }) =>
      User(
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        expiresAt: expiresAt ?? this.expiresAt,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserDatum.fromJson(json["user"]),
        accessToken: json["access_token"],
        expiresAt: DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "expires_at": expiresAt.toIso8601String(),
      };
}

class UserDatum {
  UserDatum({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.gender,
    this.avatar,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final String phone;
  final int gender;
  final String avatar;
  final int level;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UserDatum.fromRawJson(String str) =>
      UserDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        phone: json["phone"],
        gender: json["gender"],
        avatar: json["avatar"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at":
            emailVerifiedAt == null ? '' : emailVerifiedAt.toIso8601String(),
        "phone": phone,
        "gender": gender,
        "avatar": avatar,
        "level": level,
        "created_at": createdAt == null ? '' : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? '' : updatedAt.toIso8601String(),
      };
}
