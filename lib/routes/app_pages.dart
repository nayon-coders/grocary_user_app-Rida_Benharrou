import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nectar/data/binding/address_binding.dart';
import 'package:nectar/data/binding/auth_binding.dart';
import 'package:nectar/data/binding/home_binding.dart';
import 'package:nectar/middleware/auth.middleware.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/view/account_screen/controller/address_controller.dart';
import 'package:nectar/view/account_screen/delivery_address/address_list.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/view/auth/forgot_password.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/auth/new_password.dart';
import 'package:nectar/view/auth/otp_screen.dart';
import 'package:nectar/view/auth/signup_screen.dart';
import 'package:nectar/view/cart_screen/controller/car_controller.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/view/flash/flash.dart';

import '../data/binding/single_product_buind.dart';
import '../view/navigation_screen/navigation_screen.dart';

class AppPages{


  static final routes = [
      GetPage(
        name: AppRoutes.flashScreen,
        page: () => const FlashScreen(),
          middlewares: [AuthMiddleware()]
      ),
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LogInScreen(),
      binding: AuthBinding(),
      ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
      binding: AuthBinding(),
    ),
      GetPage(
      name: AppRoutes.HOME,
      page: () => const NavigationScreen(),
      bindings: [HomeBinding()],
      middlewares: [AuthMiddleware()]
      ),
    GetPage(
      name: AppRoutes.addressList,
      page: () => const AddressList(),
      bindings: [AddressBinding()],
      ),
    GetPage(
      name: AppRoutes.addressAdd,
      page: () => const DeliveryAddress(),
      bindings: [AddressBinding()],
    ),
    GetPage(
      name: AppRoutes.singleProduct,
      page: () =>  DetailScreen(),
      bindings: [SingleProductBuind(), HomeBinding()],
    ),

    GetPage(
      name: AppRoutes.forgotScreen,
      binding: AuthBinding(),
      page: () =>  ForgotPassword(),
    ),

    GetPage(
      name: AppRoutes.otpVerify,
      binding: AuthBinding(),
      page: () =>  OtpScreen(),
    ),

    GetPage(
      name: AppRoutes.newPassword,
      binding: AuthBinding(),
      page: () =>  NewPassword(),
    ),
  ];

}
