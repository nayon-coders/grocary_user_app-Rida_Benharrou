import 'package:get/get.dart';

import '../../view/account_screen/controller/address_controller.dart';
import '../../view/auth/controller/auth_controller.dart';

class AddressBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<AddressControllerNew>(()=>AddressControllerNew());
  }



}