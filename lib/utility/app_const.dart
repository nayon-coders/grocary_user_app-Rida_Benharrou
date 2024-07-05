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



String restaurantAccount = "Restaurant";
String wholeSellerAccount = "Whole Seller";
String sellerAccount = "Seller";


List orderStatus = [
  "Pending", "Accept", "Ready to ship", "Cancel", "Rejected", "Delivered"
];



ScaffoldFeatureController<SnackBar, SnackBarClosedReason> appSnackBar({required BuildContext context, required String text, required Color bgColor }){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("$text"),
    duration: Duration(milliseconds: 2000),
    backgroundColor: bgColor,
  ));
}