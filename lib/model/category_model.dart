// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? categoryName;
  final String? categoryImage;
  final String? createAt;
  final String? id;

  CategoryModel({
    this.categoryName,
    this.categoryImage,
    this.createAt,
    this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
