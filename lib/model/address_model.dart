// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AddressModel addressModelFromJson(String str) => AddressModel.fromSnapshot(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final String? id;
  final String? docId;
  final String? address;
  final String? postCode;
  final String? city;
  final String? messages;
  final String? contact;
  final String? phone;
  final String? addressType;
  final String? email;

  AddressModel({
    this.id,
    this.docId,
    this.address,
    this.postCode,
    this.city,
    this.addressType,
    this.messages,
    this.contact,
    this.phone,
    this.email,
  });

  factory AddressModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) => AddressModel(
    id: json["id"],
    docId: json.id,
    address: json["address"],
    postCode: json["post_code"],
    city: json["city"],
    messages: json["message"],
    contact: json["contact"],
    email: json["email"],
    phone: json["phone"],
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    address: json["address"],
    postCode: json["post_code"],
    city: json["city"],
    messages: json["message"],
    contact: json["contact"],
    email: json["email"],
    phone: json["phone"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "post_code": postCode,
    "city": city,
    "message": messages,
    "contact": contact,
    "address_type" : addressType,
    "email": email,
    "phone" : phone
  };
}
