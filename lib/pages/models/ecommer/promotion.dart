// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Promotion {
  Promotion({
    required this.id,
    required this.img,
    required this.normal_price,
    required this.promot_price,
    required this.start_date,
    required this.end_date,
    required this.title,
  });

  int id;
  String img;
  dynamic normal_price;
  dynamic promot_price;
  dynamic start_date;
  dynamic end_date;
  dynamic title;

  factory Promotion.fromRawJson(String str) =>
      Promotion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        img: json["img"],
        normal_price: json["normal_price"],
        promot_price: json["promot_price"],
        start_date: json["start_date"],
        end_date: json["end_date"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "normal_price": normal_price,
        "promot_price": promot_price,
        "start_date": start_date,
        "end_date": end_date,
        "title": title,
      };
}
