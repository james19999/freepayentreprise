// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.categoryId,
    required this.description,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    // required this.category,
  });

  int id;
  int qty;
  String name;
  int price;
  String img;
  int categoryId;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  // Category category;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        qty: json["qty"],
        name: json["name"],
        price: json["price"],
        img: json["img"],
        categoryId: json["category_id"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "name": name,
        "price": price,
        "img": img,
        "category_id": categoryId,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "category": category.toJson(),
      };
}
