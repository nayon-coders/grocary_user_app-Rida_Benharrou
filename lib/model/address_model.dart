// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  final String? id;
  final String? country;
  final String? state;
  final String? city;
  final String? streetNumber;
  final String? zip;
  final String? email;

  AddressModel({
    this.id,
    this.country,
    this.state,
    this.city,
    this.streetNumber,
    this.zip,
    this.email,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    streetNumber: json["street_number"],
    zip: json["zip"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "state": state,
    "city": city,
    "street_number": streetNumber,
    "zip": zip,
    "email": email,
  };
}
