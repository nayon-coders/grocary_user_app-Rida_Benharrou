// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  final bool? success;
  final String? message;
  final Data? data;

  PageModel({
    this.success,
    this.message,
    this.data,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
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
  final String? privacy;
  final String? terms;
  final String? aboutUs;
  final String? legal;

  Data({
    this.id,
    this.privacy,
    this.terms,
    this.aboutUs,
    this.legal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    privacy: json["privacy"],
    terms: json["terms"],
    aboutUs: json["about_us"],
    legal: json["legal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "privacy": privacy,
    "terms": terms,
    "about_us": aboutUs,
    "legal": legal,
  };
}
