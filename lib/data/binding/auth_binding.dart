import 'package:get/get.dart';
import 'package:nectar/view/auth/controller/forgot_controller.dart';

import '../../view/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AuthController>(()=>AuthController());
    Get.lazyPut<ForgotController>(()=>ForgotController());
  }



}