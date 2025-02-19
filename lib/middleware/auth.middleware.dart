import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nectar/routes/app_routes.dart';
import '../main.dart';
class AuthMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getString("token") == null) return RouteSettings(name: AppRoutes.LOGIN);
    //return RouteSettings(name: AppRouting.login);
  }

}