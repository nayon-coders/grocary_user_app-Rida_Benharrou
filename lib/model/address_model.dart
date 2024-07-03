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
  final String? country;
  final String? state;
  final String? city;
  final String? streetNumber;
  final String? zip;
  final String? phone;
  final String? addressType;
  final String? email;

  AddressModel({
    this.id,
    this.docId,
    this.country,
    this.state,
    this.city,
    this.addressType,
    this.streetNumber,
    this.zip,
    this.phone,
    this.email,
  });

  factory AddressModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) => AddressModel(
    id: json["id"],
    docId: json.id,
    country: json["country"],
    state: json["state"],
    addressType: json["address_type"],
    city: json["city"],
    streetNumber: json["street_number"],
    zip: json["zip"],
    email: json["email"],
    phone: json["phone"],
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    country: json["country"],
    state: json["state"],
    addressType: json["address_type"],
    city: json["city"],
    streetNumber: json["street_number"],
    zip: json["zip"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "state": state,
    "city": city,
    "street_number": streetNumber,
    "zip": zip,
    "address_type" : addressType,
    "email": email,
    "phone" : phone
  };
}
