// To parse this JSON data, do
//
//     final deliveryAddressModel = deliveryAddressModelFromJson(jsonString);

import 'dart:convert';

DeliveryAddressModel deliveryAddressModelFromJson(String str) => DeliveryAddressModel.fromJson(json.decode(str));

String deliveryAddressModelToJson(DeliveryAddressModel data) => json.encode(data.toJson());

class DeliveryAddressModel {
  final bool? success;
  final String? message;
  final List<AddressModel>? data;

  DeliveryAddressModel({
    this.success,
    this.message,
    this.data,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) => DeliveryAddressModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AddressModel>.from(json["data"]!.map((x) => AddressModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddressModel {
  final int? id;
  final int? userId;
  final String? phone;
  final String? contact;
  final String? address;
  final String? addressType;
  final String? city;
  final String? postCode;
  final String? message;

  AddressModel({
    this.id,
    this.userId,
    this.phone,
    this.contact,
    this.address,
    this.addressType,
    this.city,
    this.postCode,
    this.message,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    userId: json["user_id"],
    phone: json["phone"],
    contact: json["contact"],
    address: json["address"],
    addressType: json["address_type"],
    city: json["city"],
    postCode: json["post_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "phone": phone,
    "contact": contact,
    "address": address,
    "address_type": addressType,
    "city": city,
    "post_code": postCode,
    "message": message,
  };
}
