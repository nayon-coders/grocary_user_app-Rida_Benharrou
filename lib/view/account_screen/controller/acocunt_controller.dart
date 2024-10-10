import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/service/api.service.dart';

import '../../../data/models/myprofile_model.dart';

class AccountController extends GetxController {

  //inital
  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  //profile model 
  Rx<MyProfileModel> myProfile = MyProfileModel().obs;
  
  RxBool isLoading = false.obs;
  
  //get my profile data
  void getMyProfile() async{
    isLoading.value = true;
    var res = await ApiService().getApi(AppConfig.MY_PROFILE);
    if(res.statusCode == 200){
      myProfile.value = MyProfileModel.fromJson(jsonDecode(res.body));
    }
    isLoading.value = false;
  }

}