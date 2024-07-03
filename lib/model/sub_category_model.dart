// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  final String? id;
  final String? docId;
  final String? mainCatId;
  final String? name;
  final String? image;

  SubCategoryModel({
    this.id,
    this.docId,
    this.mainCatId,
    this.name,
    this.image,
  });

  factory SubCategoryModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>>  json) => SubCategoryModel(
    id: json["id"],
    docId: json.id,
    mainCatId: json["main_cat_id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_cat_id": mainCatId,
    "name": name,
    "image": image,
  };
}
