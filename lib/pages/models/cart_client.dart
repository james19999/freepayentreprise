// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Cart {
  Cart({
    this.id,
    this.code,
    this.created,
    this.amount,
    this.qrcode,
    this.companyId,
    this.clientId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.client,
  });

  dynamic id;
  dynamic code;
  dynamic created;
  dynamic amount;
  dynamic qrcode;
  dynamic companyId;
  dynamic clientId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  Client? client;

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        code: json["code"],
        created: json["created"],
        amount: json["amount"],
        qrcode: json["qrcode"],
        companyId: json["company_id"],
        clientId: json["client_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        client: Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "created": created,
        "amount": amount,
        "qrcode": qrcode,
        "company_id": companyId,
        "client_id": clientId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "client": client!.toJson(),
      };
}

class Client {
  Client({
    required this.id,
    required this.name,
    required this.ville,
    required this.phone,
    required this.adress,
    required this.email,
    required this.quartier,
    required this.identify,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String ville;
  String phone;
  String adress;
  String email;
  String quartier;
  String identify;
  String companyId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        ville: json["ville"],
        phone: json["phone"],
        adress: json["adress"],
        email: json["email"],
        quartier: json["quartier"],
        identify: json["identify"],
        companyId: json["company_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ville": ville,
        "phone": phone,
        "adress": adress,
        "email": email,
        "quartier": quartier,
        "identify": identify,
        "company_id": companyId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
