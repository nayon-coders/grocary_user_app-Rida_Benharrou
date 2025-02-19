import 'package:get/get.dart';
import 'package:nectar/view/detail_screen/controller/details_screen_controller.dart';

import '../../view/auth/controller/auth_controller.dart';

class SingleProductBuind extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<DetailsScreenController>(()=>DetailsScreenController());
  }



}