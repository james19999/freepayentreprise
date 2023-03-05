// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Welcome {
  Welcome({
    required this.order,
    required this.message,
    required this.token,
    required this.status,
  });

  List<Order> order;
  String message;
  dynamic token;
  bool status;

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        order: List<Order>.from(json[" Order"].map((x) => Order.fromJson(x))),
        message: json["message"],
        token: json["token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        " Order": List<dynamic>.from(order.map((x) => x.toJson())),
        "message": message,
        "token": token,
        "status": status,
      };
}

class Order {
  Order({
    required this.id,
    required this.userId,
    required this.clientId,
    required this.createdAt,
    required this.updatedAt,
    required this.client,
  });

  int id;
  String userId;
  String clientId;
  DateTime createdAt;
  DateTime updatedAt;
  Client client;

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        clientId: json["client_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        client: Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "client_id": clientId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "client": client.toJson(),
      };
}

class Client {
  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.adress,
    required this.quartier,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String phone;
  String city;
  String adress;
  String quartier;
  DateTime createdAt;
  DateTime updatedAt;

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        adress: json["adress"],
        quartier: json["quartier"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "city": city,
        "adress": adress,
        "quartier": quartier,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
