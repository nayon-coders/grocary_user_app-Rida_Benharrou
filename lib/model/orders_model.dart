// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:nectar/model/product_model.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final List<Item>? items;
  final String? id;
  final String? paymentMethod;
  final String? deliveryAddress;
  final String? date;
  final String? status;
  final String? user;

  OrderModel({
    this.items,
    this.id,
    this.paymentMethod,
    this.deliveryAddress,
    this.date,
    this.status,
    this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    id: json["id"],
    paymentMethod: json["payment_method"],
    deliveryAddress: json["delivery_address"],
    date: json["date"].toString(),
    status: json["status"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "id": id,
    "payment_method": paymentMethod,
    "delivery_address": deliveryAddress,
    "date": date,
    "status": status,
    "user": user,
  };
}

class Item {
  final String? price;
  final int? qty;
  final ProductModel? product;

  Item({
    this.price,
    this.qty,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    price: json["price"],
    qty: json["qty"],
    product: ProductModel.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "qty": qty,
    "product": product,
  };
}
