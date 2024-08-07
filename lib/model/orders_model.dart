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
  final String? totalAmount;
  final String? subTotal;
  final String? tax;
  final String? taxAmount;
  final String? deliveryFee;
  final String? deliveryDate;

  OrderModel({
    this.id,
    this.docId,
    this.products,
    this.createBy,
    this.createAt,
    this.orderStatus,
    this.address,
    this.paymentMethod,
    this.totalAmount,
    this.subTotal,
    this.tax,
    this.deliveryFee,
    this.deliveryDate,
    this.taxAmount
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
    totalAmount: json["total"],
    subTotal: json["sub_total"],
    tax: json["tax"],
    deliveryFee: json["delivery_fee"],
    deliveryDate: json["delivery_date"] ?? "",
    taxAmount: json["tax_amount"] ?? ""

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "create_by": createBy,
    "create_at": createAt,
    "order_status": orderStatus,
    "address": address!.toJson(),
    "payment_method": paymentMethod,
    "total" : totalAmount,
    "sub_total" : subTotal,
    "tax" : tax,
    "delivery_fee" : deliveryFee,
    "delivery_date" : deliveryDate,
    "tax_amount" : taxAmount.toString()
  };
}

class Product {
  final ProductModel? productInfo;
  final String? qty;
  final String? itemPrice;
  final String? tax;

  Product({
    this.productInfo,
    this.qty,
    this.itemPrice,
    this.tax
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productInfo: ProductModel.fromJson(json["product_info"]),
    qty: json["qty"].toString(),
    itemPrice: json["item_price"].toString(),
    tax: json["tax"]

  );

  Map<String, dynamic> toJson() => {
    "product_info": productInfo,
    "qty": qty,
    "item_price" : itemPrice,
    "tax" : tax
  };
}
