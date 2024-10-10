// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  final bool? success;
  final String? message;
  final int? totalCategories;
  final List<SingleCategory>? data;

  CategoryListModel({
    this.success,
    this.message,
    this.totalCategories,
    this.data,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    success: json["success"],
    message: json["message"],
    totalCategories: json["totalCategories"],
    data: json["data"] == null ? [] : List<SingleCategory>.from(json["data"]!.map((x) => SingleCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "totalCategories": totalCategories,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleCategory {
  final int? id;
  final String? name;
  final String? image;
  final List<SingleCategory>? subCategories;

  SingleCategory({
    this.id,
    this.name,
    this.image,
    this.subCategories,
  });

  factory SingleCategory.fromJson(Map<String, dynamic> json) => SingleCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    subCategories: json["sub_categories"] == null ? [] : List<SingleCategory>.from(json["sub_categories"]!.map((x) => SingleCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "sub_categories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}
