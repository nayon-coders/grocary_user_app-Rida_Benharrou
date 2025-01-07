
import 'package:flutter/material.dart';


class AppConfig{

  //email send api
  static const String EMAIL_SEND_API = "https://email-sender-hn6l.onrender.com/send-email";


  //url
  static const String DOMAIN = "https://grocary-ecommerce.vercel.app";
  static const String API = "api/v1";
  static const String BASE_URL = "${DOMAIN}/$API";

  //USER
  static const String SIGNUP = "$BASE_URL/user/signup";
  static const String LOGIN = "$BASE_URL/user/login";
  static const String MY_PROFILE = "$BASE_URL/user/me";
  static const String UPDATE_USER = "$BASE_URL/user/update";
  static const String USER_PASS_UPDATE = "$BASE_URL/user/password";
  static const String USER_DELETE = "$BASE_URL/user/delete/";

  //product
  static const String PRPDUCT_GET = "$BASE_URL/product/all?limit=1000";
  static const String PRPDUCT_SINGLE = "$BASE_URL/product/";
  static const String POST_CODE_GET = "$BASE_URL/product/post-code";

  //category
  static const String CATEGORY_GET = "$BASE_URL/category";

  //delivery address
  static const String DELIVERY_ADDRESS = "$BASE_URL/delivery-addresss";
  static const String DELIVERY_ADDRESS_delete = "$BASE_URL/delivery-addresss/delete/";
  static const String DELIVERY_ADDRESS_UPDATE = "$BASE_URL/delivery-addresss/update/";
  static const String DELIVERY_ADDRESS_ADD = "$BASE_URL/delivery-addresss/create";


  //fav
  static const String FAVORITE_ADD = "$BASE_URL/favorite/add";
  static const String FAVORITE_GET = "$BASE_URL/favorite/all";
  static const String FAVORITE_REMOVE = "$BASE_URL/favorite/delete/";
  static const String FAVORITE_CHECK = "$BASE_URL/favorite/check/";

  //cart
  static const String CART_ADD = "$BASE_URL/cart/addproduct";
  static const String CART_GET = "$BASE_URL/cart/all";
  static const String CART_REMOVE = "$BASE_URL/cart/delete/";
  static const String CART_UPDATE = "$BASE_URL/cart/update";
  static const String RECOMANDATION_PRODUCT = "$BASE_URL/product/random";


  //order
  static const String ORDER_PLACE = "$BASE_URL/order/create";
  static const String ORDER_SINGLE_GET = "$BASE_URL/order/";
  static const String ORDER_GET_ALL = "$BASE_URL/order/my";
  static const String ORDER_BULK_DELETE = "$BASE_URL/cart/delete/bulk";
  static const String pageLink = "$BASE_URL/settings/privacy";





}