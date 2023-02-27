// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class ClientModel {
  ClientModel({
    this.id,
    this.name,
    this.phone,
    this.adress,
    this.email,
    this.ville,
    this.identify,
    this.quartier,
    this.companyId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic adress;
  dynamic email;
  dynamic ville;
  dynamic identify;
  dynamic quartier;
  dynamic companyId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  factory ClientModel.fromRawJson(String str) =>
      ClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        adress: json["adress"],
        email: json["email"],
        ville: json["ville"],
        identify: json["identify"],
        quartier: json["quartier"],
        companyId: json["company_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "adress": adress,
        "email": email,
        "ville": ville,
        "identify": identify,
        "quartier": quartier,
        "company_id": companyId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
