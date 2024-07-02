// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/model/product_model.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  final String? id;
  final String? docId;
  final List<Product>? products;
  final String? createBy;
  final String? createAt;
  final String? orderStatus;
  final AddressModel? address;
  final String? paymentMethod;

  OrderModel({
    this.id,
    this.docId,
    this.products,
    this.createBy,
    this.createAt,
    this.orderStatus,
    this.address,
    this.paymentMethod,
  });

  factory OrderModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) => OrderModel(
    id: json["id"],
    docId: json.id,
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    createBy: json["create_by"],
    createAt: json["create_at"],
    orderStatus: json["order_status"],
    address: AddressModel.fromJson(json["address"]),
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "create_by": createBy,
    "create_at": createAt,
    "order_status": orderStatus,
    "address": address!.toJson(),
    "payment_method": paymentMethod,
  };
}

class Product {
  final ProductModel? productInfo;
  final String? qty;

  Product({
    this.productInfo,
    this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productInfo: ProductModel.fromJson(json["product_info"]),
    qty: json["qty"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "product_info": productInfo,
    "qty": qty,
  };
}
