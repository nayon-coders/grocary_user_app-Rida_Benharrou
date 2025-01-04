// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  final bool? success;
  final String? message;
  final Pagination? pagination;
  final List<SingleProduct>? data;

  ProductListModel({
    this.success,
    this.message,
    this.pagination,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<SingleProduct>.from(json["data"]!.map((x) => SingleProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleProduct {
  final dynamic? id;
  final dynamic? categoryId;
  final String? name;
  final String? productType;
  final String? unit;
  final String? longDescription;
  final String? shortDescription;
  final String? status;
  final dynamic? tax;
  final String? packaging;
  final String? uvw;
  final String? country;
  final dynamic? isStock;
  final dynamic? inStock;
  final String? createdAt;
  final String? updatedAt;
  final dynamic? purchasePrice;
  final dynamic? regularPrice;
  final dynamic? sellingPrice;
  final dynamic? wholePrice;
  final dynamic? discountPrice;
  final dynamic? supperMarcent;
  final String? categoryImage;
  final String? categoryName;
  final List<ProductImages>? images;
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
    this.packaging,
    this.uvw,
    this.country,
    this.isStock,
    this.inStock,
    this.createdAt,
    this.updatedAt,
    this.purchasePrice,
    this.regularPrice,
    this.sellingPrice,
    this.wholePrice,
    this.discountPrice,
    this.supperMarcent,
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
    tax: json["tax"],
    packaging: json["packaging"],
    uvw: json["uvw"],
    country: json["country"],
    isStock: json["is_stock"],
    inStock: json["in_stock"],
    createdAt: json["created_at"] ,
    updatedAt: json["updated_at"],
    purchasePrice: json["purchase_price"] ,
    regularPrice: json["regular_price"] ,
    sellingPrice: json["selling_price"],
    wholePrice: json["whole_price"] ,
    discountPrice: json["discount_price"],
    supperMarcent: json["supper_marcent"],
    categoryImage: json["category_image"],
    categoryName: json["category_name"],
    images: json["images"] == null ? [] : List<ProductImages>.from(json["images"]!.map((x) => ProductImages.fromJson(x))),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    subcategories: json["subcategories"] == null ? [] : List<Subcategory?>.from(json["subcategories"]!.map((x) => x == null ? null : Subcategory.fromJson(x))),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "product_type": productTypeValues.reverse[productType],
    "unit": longDescriptionValues.reverse[unit],
    "long_description": longDescriptionValues.reverse[longDescription],
    "short_description": shortDescriptionValues.reverse[shortDescription],
    "status": statusValues.reverse[status],
    "tax": tax,
    "packaging": packaging,
    "uvw": uvw,
    "country": countryValues.reverse[country],
    "is_stock": isStock,
    "in_stock": inStock,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "purchase_price": purchasePrice,
    "regular_price": regularPrice,
    "selling_price": sellingPrice,
    "whole_price": wholePrice,
    "discount_price": discountPrice,
    "supper_marcent": supperMarcent,
    "category_image": categoryImage,
    "category_name": categoryNameValues.reverse[categoryName],
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x?.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

enum CategoryName {
  EDIT_TEST,
  FRUITS
}

class ProductImages {
  final int? imageId;
  final String? imageUrl;

  ProductImages({
    this.imageId,
    this.imageUrl,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
    imageId: json["image_id"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
    "image_url": imageUrl,
  };
}

final categoryNameValues = EnumValues({
  "edit test": CategoryName.EDIT_TEST,
  "FRUITS": CategoryName.FRUITS
});

enum Country {
  BAHAMAS,
  BELGIQUE,
  FRANCE
}

final countryValues = EnumValues({
  "Bahamas": Country.BAHAMAS,
  "Belgique": Country.BELGIQUE,
  "France": Country.FRANCE
});

enum LongDescription {
  EMPTY,
  G_G,
  THE_90
}

final longDescriptionValues = EnumValues({
  " ": LongDescription.EMPTY,
  "G (€ / G)": LongDescription.G_G,
  " 90": LongDescription.THE_90
});

enum ProductType {
  KG_KG,
  U_U
}

final productTypeValues = EnumValues({
  "KG (€ / Kg)": ProductType.KG_KG,
  "U (€ / U)": ProductType.U_U
});

enum ShortDescription {
  LA_PICE,
  LE_KILO
}

final shortDescriptionValues = EnumValues({
  "La Pièce": ShortDescription.LA_PICE,
  "Le Kilo": ShortDescription.LE_KILO
});

enum Status {
  ACTIVE,
  INACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "inactive": Status.INACTIVE
});

class Subcategory {
  final dynamic? subCategoryId;
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

class Pagination {
  final dynamic? totalProducts;
  final dynamic? page;
  final dynamic? limit;
  final dynamic? totalPages;

  Pagination({
    this.totalProducts,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalProducts: json["totalProducts"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "totalProducts": totalProducts,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
