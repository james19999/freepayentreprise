// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:freepayagency/pages/models/ecommer/product.dart';

class Categorys {
  Categorys({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  int id;
  String name;
  String img;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> products;

  factory Categorys.fromRawJson(String str) =>
      Categorys.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
