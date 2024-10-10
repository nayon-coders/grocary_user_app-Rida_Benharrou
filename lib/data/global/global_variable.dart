import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/fav_list_model.dart';
import '../models/myprofile_model.dart';

class GlobalVariables {
  static RxDouble gPrice = 0.0.obs;
  static bool gIsDarkMode = false;
  static BuildContext? currentContext;
  static RxDouble productPriceInKg = 0.00.obs;
  static RxString productTypeNameInKg = "".obs;
  static RxBool isFav = false.obs;
  static RxString selectedFavId = "".obs;
  static RxList<SingleFavList> favList = <SingleFavList>[].obs;

  static Rx<MyProfileModel> myProfile = MyProfileModel().obs;

}
