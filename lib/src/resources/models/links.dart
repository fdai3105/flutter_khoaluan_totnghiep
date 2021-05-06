// Dart imports:
import 'dart:convert';

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  final String first;
  final String last;
  final dynamic prev;
  final String next;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}
