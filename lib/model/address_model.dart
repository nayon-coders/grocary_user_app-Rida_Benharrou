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
  final String? streetName;
  final String? streetNumber;
  final String? zip;
  final String? email;
  final String? addressType;

  AddressModel( {
    this.id,
    this.country,
    this.state,
    this.city,
    this.streetName,
    this.zip,
    this.email,
    this.streetNumber,
    this.addressType
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    streetName: json["street_name"],
    zip: json["zip"],
    email: json["email"],
    streetNumber: json["street_number"],
    addressType: json["address_type"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "state": state,
    "city": city,
    "street_number": streetNumber,
    "street_name" : streetName,
    "zip": zip,
    "email": email,
    "address_type" : addressType
  };
}
