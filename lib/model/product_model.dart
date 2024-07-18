// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? id;
  final String? docId;
  final String? name;
  final String? shortDescription;
  final String? longDescription;
  final List<dynamic>? productsTags;
  final List<dynamic>? images;
  final String? regularPrice;
  final String? wholePrice;
  final String? sellingPrice;
  final String? discountPrice;
  final CategoryS? categoryS;
  final String? subCategory;
  final Variants? variants;
  final String? status;
  final String? isStock;
  final String? productType;
  final String? createAt;
  final String? country;
  final String? tax;

  ProductModel({
    this.id,
    this.docId,
    this.name,
    this.shortDescription,
    this.longDescription,
    this.productsTags,
    this.images,
    this.regularPrice,
    this.wholePrice,
    this.sellingPrice,
    this.discountPrice,
    this.categoryS,
    this.variants,
    this.status,
    this.isStock,
    this.productType,
    this.createAt,
    this.subCategory,
    this.country,
    this.tax
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    productsTags: json["products_tags"] == null ? [] : List<dynamic>.from(json["products_tags"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    regularPrice: json["regular_price"],
    wholePrice: json["whole_price"],
    sellingPrice: json["selling_price"],
    discountPrice: json["discount_price"],
    categoryS: json["category's"] == null ? null : CategoryS.fromJson(json["category's"]),
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    status: json["status"],
    isStock: json["is_stock"],
    productType: json["product_type"],
    createAt: json["create_at"],
    subCategory: json["sub_category"],
    country: json["country"] ?? "",
    tax: json["tax"] ?? ""

  );


  factory ProductModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> json) => ProductModel(
    id: json["id"],
    docId: json.id,
    name: json["name"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    productsTags: json["products_tags"] == null ? [] : List<dynamic>.from(json["products_tags"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
    regularPrice: json["regular_price"],
    wholePrice: json["whole_price"],
    sellingPrice: json["selling_price"],
    discountPrice: json["discount_price"],
    categoryS: json["category's"] == null ? null : CategoryS.fromJson(json["category's"]),
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    status: json["status"],
    isStock: json["is_stock"],
    productType: json["product_type"],
    createAt: json["create_at"],
    subCategory: json["sub_category"],
    country: json["country"] ?? "",
    tax: json["tax"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_description": shortDescription,
    "long_description": longDescription,
    "products_tags": productsTags == null ? [] : List<dynamic>.from(productsTags!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "regular_price": regularPrice,
    "whole_price": wholePrice,
    "selling_price": sellingPrice,
    "discount_price": discountPrice,
    "category's": categoryS?.toJson(),
    "variants": variants?.toJson(),
    "status": status,
    "is_stock": isStock,
    "product_type": productType,
    "create_at": createAt,
    "sub_category" : subCategory

  };
}

class CategoryS {
  final String? id;
  final String? categoryName;
  final String? categoryImage;
  final String? createAt;

  CategoryS({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.createAt,
  });

  factory CategoryS.fromJson(Map<String, dynamic> json) => CategoryS(
    id: json["id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_image": categoryImage,
    "create_at": createAt,
  };
}

class Variants {
  final String? variants;
  final List<ValiantsList>? valiantsList;

  Variants({
    this.variants,
    this.valiantsList,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    variants: json["variants"],
    valiantsList: json["valiants_list"] == null ? [] : List<ValiantsList>.from(json["valiants_list"]!.map((x) => ValiantsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "variants": variants,
    "valiants_list": valiantsList == null ? [] : List<dynamic>.from(valiantsList!.map((x) => x.toJson())),
  };
}

class ValiantsList {
  final String? name;
  final String? prince;

  ValiantsList({
    this.name,
    this.prince,
  });

  factory ValiantsList.fromJson(Map<String, dynamic> json) => ValiantsList(
    name: json["name"],
    prince: json["prince"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "prince": prince,
  };
}