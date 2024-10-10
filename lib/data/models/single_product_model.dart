// To parse this JSON data, do
//
//     final singleProductModel = singleProductModelFromJson(jsonString);

import 'dart:convert';

SingleProductModel singleProductModelFromJson(String str) => SingleProductModel.fromJson(json.decode(str));

String singleProductModelToJson(SingleProductModel data) => json.encode(data.toJson());

class SingleProductModel {
  final bool? success;
  final String? message;
  final Data? data;

  SingleProductModel({
    this.success,
    this.message,
    this.data,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? productType;
  final String? unit;
  final String? longDescription;
  final String? shortDescription;
  final String? status;
  final double? tax;
  final String? country;
  final int? isStock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? purchasePrice;
  final double? regularPrice;
  final double? sellingPrice;
  final double? wholePrice;
  final double? discountPrice;
  final List<Image>? images;
  final List<dynamic>? variants;
  final List<Subcategory>? subcategories;
  final List<dynamic>? tags;

  Data({
    this.id,
    this.categoryId,
    this.name,
    this.productType,
    this.unit,
    this.longDescription,
    this.shortDescription,
    this.status,
    this.tax,
    this.country,
    this.isStock,
    this.createdAt,
    this.updatedAt,
    this.purchasePrice,
    this.regularPrice,
    this.sellingPrice,
    this.wholePrice,
    this.discountPrice,
    this.images,
    this.variants,
    this.subcategories,
    this.tags,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    productType: json["product_type"],
    unit: json["unit"],
    longDescription: json["long_description"],
    shortDescription: json["short_description"],
    status: json["status"],
    tax: json["tax"]?.toDouble(),
    country: json["country"],
    isStock: json["is_stock"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    purchasePrice: json["purchase_price"],
    regularPrice: json["regular_price"]?.toDouble(),
    sellingPrice: json["selling_price"]?.toDouble(),
    wholePrice: json["whole_price"]?.toDouble(),
    discountPrice: json["discount_price"]?.toDouble(),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "product_type": productType,
    "unit": unit,
    "long_description": longDescription,
    "short_description": shortDescription,
    "status": status,
    "tax": tax,
    "country": country,
    "is_stock": isStock,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "purchase_price": purchasePrice,
    "regular_price": regularPrice,
    "selling_price": sellingPrice,
    "whole_price": wholePrice,
    "discount_price": discountPrice,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class Image {
  final String? imageUrl;

  Image({
    this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
  };
}

class Subcategory {
  final int? subCategoryId;
  final String? subCategoryImage;
  final String? subCategoryName;

  Subcategory({
    this.subCategoryId,
    this.subCategoryImage,
    this.subCategoryName,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    subCategoryId: json["subCategory_id"],
    subCategoryImage: json["subCategory_image"],
    subCategoryName: json["subCategory_name"],
  );

  Map<String, dynamic> toJson() => {
    "subCategory_id": subCategoryId,
    "subCategory_image": subCategoryImage,
    "subCategory_name": subCategoryName,
  };
}
