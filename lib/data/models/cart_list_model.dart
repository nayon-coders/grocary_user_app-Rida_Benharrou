// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
  final bool? success;
  final String? message;
  final String? userName;
  final String? userEmail;
  final int? totalProducts;
  final List<SingleCartItem>? data;

  CartListModel({
    this.success,
    this.message,
    this.userName,
    this.userEmail,
    this.totalProducts,
    this.data,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
    success: json["success"],
    message: json["message"],
    userName: json["userName"],
    userEmail: json["userEmail"],
    totalProducts: json["totalProducts"],
    data: json["data"] == null ? [] : List<SingleCartItem>.from(json["data"]!.map((x) => SingleCartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "userName": userName,
    "userEmail": userEmail,
    "totalProducts": totalProducts,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCartItem {
  final int? id;
  final int? userId;
  final int? productId;
  final int? quantity;
  final DateTime? createdAt;
  final String? productName;
  final String? productType;
  final String? productUnit;
  final double? productTax;
  final int? productIsStock;
  final int? productPurchasePrice;
  final double? productRegularPrice;
  final double? productSellingPrice;
  final double? productWholePrice;
  final double? productDiscountPrice;
  final String? productImages;

  SingleCartItem({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.createdAt,
    this.productName,
    this.productType,
    this.productUnit,
    this.productTax,
    this.productIsStock,
    this.productPurchasePrice,
    this.productRegularPrice,
    this.productSellingPrice,
    this.productWholePrice,
    this.productDiscountPrice,
    this.productImages,
  });

  factory SingleCartItem.fromJson(Map<String, dynamic> json) => SingleCartItem(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    productName: json["product_name"],
    productType: json["product_type"],
    productUnit: json["product_unit"],
    productTax: json["product_tax"]?.toDouble(),
    productIsStock: json["product_is_stock"],
    productPurchasePrice: json["product_purchase_price"],
    productRegularPrice: json["product_regular_price"]?.toDouble(),
    productSellingPrice: json["product_selling_price"]?.toDouble(),
    productWholePrice: json["product_whole_price"]?.toDouble(),
    productDiscountPrice: json["product_discount_price"]?.toDouble(),
    productImages: json["product_images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "created_at": createdAt?.toIso8601String(),
    "product_name": productName,
    "product_type": productType,
    "product_unit": productUnit,
    "product_tax": productTax,
    "product_is_stock": productIsStock,
    "product_purchase_price": productPurchasePrice,
    "product_regular_price": productRegularPrice,
    "product_selling_price": productSellingPrice,
    "product_whole_price": productWholePrice,
    "product_discount_price": productDiscountPrice,
    "product_images": productImages,
  };
}
