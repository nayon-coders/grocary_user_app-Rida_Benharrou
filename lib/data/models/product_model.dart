// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  final bool? success;
  final String? message;
  final int? totalProducts;
  final int? totalPages;
  final int? currentPage;
  final List<SingleProduct>? data;

  ProductListModel({
    this.success,
    this.message,
    this.totalProducts,
    this.totalPages,
    this.currentPage,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    success: json["success"],
    message: json["message"],
    totalProducts: json["totalProducts"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    data: json["data"] == null ? [] : List<SingleProduct>.from(json["data"]!.map((x) => SingleProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "totalProducts": totalProducts,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleProduct {
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
  final String? categoryImage;
  final String? categoryName;
  final List<Image>? images;
  final List<dynamic>? variants;
  final List<Subcategory?>? subcategories;
  final List<dynamic>? tags;

  SingleProduct({
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
    this.categoryImage,
    this.categoryName,
    this.images,
    this.variants,
    this.subcategories,
    this.tags,
  });

  factory SingleProduct.fromJson(Map<String, dynamic> json) => SingleProduct(
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
    categoryImage: json["category_image"],
    categoryName: json["category_name"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    subcategories: json["subcategories"] == null ? [] : List<Subcategory?>.from(json["subcategories"]!.map((x) => x == null ? null : Subcategory.fromJson(x))),
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
    "category_image": categoryImage,
    "category_name": categoryName,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x?.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class Image {
  final int? imageId;
  final String? imageUrl;

  Image({
    this.imageId,
    this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageId: json["image_id"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
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
