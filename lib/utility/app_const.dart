import 'dart:ui';

import 'package:flutter/material.dart';


String categoryCollection = "category";
String subCategoryCollection = "sub_category";
String productCollection = "products";
String variantCollection = "variants";
String bannerCollection = "banners";
String usersCollection = "users";
String logoCollection = "app_logo";
String appSettingCollection = "app_setting";
String favCollection = "favorite";
String userCollection = "users";
String cartCollection = "cart";
String addressCollection = "user_delivery_address";
String settingCollection = "settings";
String ordersCollection = "orders";
String postCodeCollection = "post_code";



String restaurantAccount = "Restauration";
String wholeSellerAccount = "Grossiste";
String sellerAccount = "Revendeur";
String supperMarcent = "Supper Marcen";


List orderStatus = [
  //"En attente", "Confirmée", "Expédition", "Annulée", "Rejetée", "Livrée"
  "Reçue en attente", "En préparation", "En cours de livraison", "Livré", "À régler", "Terminé"
];



ScaffoldFeatureController<SnackBar, SnackBarClosedReason> appSnackBar({required BuildContext context, required String text, required Color bgColor }){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("$text"),
    duration: Duration(milliseconds: 2000),
    backgroundColor: bgColor,
  ));
}



//check the ML, CM, MG ect
List unitList = [
  {
    "name" : "KG (€ / KG)",
    "inKg" : 1000,
    "kgName" : "KG"
  },
  {
    "name" : "G (€ / G)",
    "inKg" : 1000,
    "kgName" : "KG"
  },
  {
    "name" : "MG (€ / MG)",
    "inKg" : 1000*1000,
    "kgName" : "KG"
  },
  {
    "name" : "ML (€ / ML)",
    "inKg" : 1000,
    "kgName" : "L"
  },
  {
    "name" : "CM (€ / CM)",
    "inKg" : 100,
    "kgName" : "M"
  },
  {
    "name" : "MM (€ / MM)",
    "inKg" : 1000,
    "kgName" : "M"
  },
  {
    "name" : "U (€ / U)",
    "inKg" : 12,
    "kgName" : "U "
  }
];