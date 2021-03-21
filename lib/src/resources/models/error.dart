import 'dart:convert';

class Error {
  Error({
    this.message,
    this.errors,
  });

  final String message;
  final Map errors;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    message: json["message"],
    errors: Map.from(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": json.encode(errors),
  };
}