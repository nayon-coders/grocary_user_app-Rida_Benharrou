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
  final String? accountType;
  final String? status;
  final String? createAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.accountType,
    this.status,
    this.createAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    accountType: json["account_type"],
    status: json["status"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "account_type": accountType,
    "status": status,
    "create_at": createAt,
  };
}
