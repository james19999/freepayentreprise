// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class History {
    History({
        required this.amount,
        required this.cartNumber,
        required this.companyId,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    dynamic amount;
    String cartNumber;
    String companyId;
    int id;
    DateTime createdAt;
    DateTime updatedAt;

    factory History.fromJson(Map<String, dynamic> json) => History(
        amount: json["amount"],
        cartNumber: json["cart_number"],
        companyId: json["company_id"],
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "cart_number": cartNumber,
        "company_id": companyId,
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
