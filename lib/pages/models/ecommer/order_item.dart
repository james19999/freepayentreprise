// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Ordersitem {
  Ordersitem({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  int id;
  String productId;
  String orderId;
  int qty;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  factory Ordersitem.fromRawJson(String str) =>
      Ordersitem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ordersitem.fromJson(Map<String, dynamic> json) => Ordersitem(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "order_id": orderId,
        "qty": qty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}

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
  });

  int id;
  String name;
  int price;
  String img;
  int categoryId;
  String description;
  int qty;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        img: json["img"],
        categoryId: json["category_id"],
        description: json["description"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "category_id": categoryId,
        "description": description,
        "qty": qty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
