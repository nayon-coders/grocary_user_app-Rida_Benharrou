import 'package:get/get.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/view/cart_screen/controller/car_controller.dart';

import '../../view/account_screen/controller/acocunt_controller.dart';
import '../../view/auth/controller/auth_controller.dart';
import '../../view/favorite_screen/controller/fav_controller.dart';
import '../../view/shop_screen/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<HomeController>(()=>HomeController());
    Get.lazyPut<HomeController>(()=>HomeController());
    Get.lazyPut<AccountController>(()=>AccountController());
    Get.lazyPut<GlobalController>(()=>GlobalController());
    Get.lazyPut<FavController>(()=>FavController());
    Get.lazyPut<CartControllerNew>(()=>CartControllerNew());
  }



}