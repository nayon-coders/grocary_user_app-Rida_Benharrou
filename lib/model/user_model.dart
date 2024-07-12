// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? company;
  final String? brand;
  final String? address;
  final String? postCode;
  final String? contactFacturation;
  final String? contactComptabilit;
  final String? accountEmail;
  final String? accountPhone;
  final String? city;
  final String? siret;
  final String? accountType;
  final String? status;
  final String? createAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.company,
    this.brand,
    this.address,
    this.postCode,
    this.city,
    this.siret,
    this.contactFacturation,
    this.contactComptabilit,
    this.accountEmail,
    this.accountPhone,
    this.accountType,
    this.status,
    this.createAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    company: json["company"],
    brand: json["brand"],
    address: json["address"],
    postCode: json["post_code"],
    city: json["city"],
    siret: json["siret"],
    contactFacturation: json["contract_facturation"],
    contactComptabilit: json["contract_comptabilité"],
    accountEmail: json["account_email"],
    accountPhone: json["account_phone"],
    accountType: json["account_type"],
    status: json["status"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "company" : company,
    "brand" : brand,
    "post_code": postCode,
    "city" : city,
    "siret" : siret,
    "contract_facturation" : contactFacturation,
    "contract_comptabilité" : contactComptabilit,
    "account_email" : accountEmail,
    "account_phone" : accountPhone,
    "account_type": accountType,
    "status": status,
    "create_at": createAt,
  };
}
