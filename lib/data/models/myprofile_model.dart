// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? accountEmail;
  final String? accountPhone;
  final String? accountType;
  final String? brand;
  final String? city;
  final String? company;
  final String? contractComptabilit;
  final String? contractFacturation;
  final String? postCode;
  final String? siret;
  final String? status;
  final DateTime? createAt;
  final DateTime? updateAt;

  MyProfileModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.accountEmail,
    this.accountPhone,
    this.accountType,
    this.brand,
    this.city,
    this.company,
    this.contractComptabilit,
    this.contractFacturation,
    this.postCode,
    this.siret,
    this.status,
    this.createAt,
    this.updateAt,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    accountEmail: json["account_email"],
    accountPhone: json["account_phone"],
    accountType: json["account_type"],
    brand: json["brand"],
    city: json["city"],
    company: json["company"],
    contractComptabilit: json["contract_comptabilité"],
    contractFacturation: json["contract_facturation"],
    postCode: json["post_code"],
    siret: json["siret"],
    status: json["status"],
    createAt: json["create_at"] == null ? null : DateTime.parse(json["create_at"]),
    updateAt: json["update_at"] == null ? null : DateTime.parse(json["update_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "account_email": accountEmail,
    "account_phone": accountPhone,
    "account_type": accountType,
    "brand": brand,
    "city": city,
    "company": company,
    "contract_comptabilité": contractComptabilit,
    "contract_facturation": contractFacturation,
    "post_code": postCode,
    "siret": siret,
    "status": status,
    "create_at": createAt?.toIso8601String(),
    "update_at": updateAt?.toIso8601String(),
  };
}
