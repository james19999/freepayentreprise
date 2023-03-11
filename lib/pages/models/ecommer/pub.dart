// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Pubs {
  Pubs({
    required this.id,
    required this.img,
  });

  int id;
  String img;

  factory Pubs.fromRawJson(String str) => Pubs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pubs.fromJson(Map<String, dynamic> json) => Pubs(
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
      };
}
