// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  final Category? category;
  final String? image;

  BannerModel({
    this.category,
    this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "image": image,
  };
}

class Category {
  final String? categoryName;
  final String? categoryImage;
  final String? createAt;
  final String? id;

  Category({
    this.categoryName,
    this.categoryImage,
    this.createAt,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
    createAt: json["create_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "category_name": categoryName,
    "category_image": categoryImage,
    "create_at": createAt,
    "id": id,
  };
}
