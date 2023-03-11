// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Sliders {
  Sliders({
    required this.id,
    required this.img,
    required this.description,
  });

  int id;
  String img;
  String description;

  factory Sliders.fromRawJson(String str) => Sliders.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
        id: json["id"],
        img: json["img"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "description": description,
      };
}
