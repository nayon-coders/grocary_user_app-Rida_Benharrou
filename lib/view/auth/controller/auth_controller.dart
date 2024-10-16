import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/global/global_variable.dart';
import 'package:nectar/data/models/myprofile_model.dart';
import 'package:nectar/data/service/api.service.dart';
import 'package:http/http.dart' as http;
import 'package:nectar/main.dart';
import 'package:nectar/routes/app_routes.dart';

class AuthController extends GetxController{

  //test input feild
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> companyController = TextEditingController().obs;
  Rx<TextEditingController> brandController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> postCodeController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> stratController = TextEditingController().obs;
  Rx<TextEditingController> contactFacturation = TextEditingController().obs;
  Rx<TextEditingController> contactComptabilit = TextEditingController().obs;
  Rx<TextEditingController> contactEmail = TextEditingController().obs;
  Rx<TextEditingController> contactPhone = TextEditingController().obs;
  RxList<String> accountTypeName = ["Restauration", "Revendeur", "Grossiste"].obs;
  RxList<String> selectedAccountType = <String>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyProfile();

  }

  //signup
  RxBool isSignUp = false.obs;
  Future signUp()async{
    isSignUp.value = true;
    var data = {
      "name": contactFacturation.value.text,
      "email": emailController.value.text,
      "password": passwordController.value.text,
      "account_email": emailController.value.text,
      "account_phone": contactPhone.value.text,
      "account_type": selectedAccountType.value[0],
      "brand": brandController.value.text,
      "city": cityController.value.text,
      "company": companyController.value.text,
      "contract_comptabilité": "N/A",
      "contract_facturation": contactFacturation.value.text,
      "post_code":postCodeController.value.text,
      "siret": stratController.value.text
    };
    print("body  =---- ${data}");
    var response = await http.post(Uri.parse(AppConfig.SIGNUP),
      body: jsonEncode(data),
      headers: {
        "Accept" : "application/json",
        "Content-Type" : "application/json"
      }
    );
    print("response =---- ${response.statusCode}");
    print("response =---- ${response.body}");
    if(response.statusCode == 200){
      Get.offAllNamed(AppRoutes.HOME);
      Get.snackbar("Success!", "Account has been created.", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "Something went wrong with server.", backgroundColor: Colors.red);
    }
    isSignUp.value = false;
  }



  //login
  RxBool isLogin = false.obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> pass = TextEditingController().obs;
  login()async{
    isLogin.value = true;
    var data = {
      "email": email.value.text,
      "password": pass.value.text
    };
    var res = await http.post(Uri.parse(AppConfig.LOGIN),
        body: jsonEncode(data),
        headers: {
          "Accept" : "application/json",
          "Content-Type" : "application/json"
        }
    );
    if(res.statusCode == 200){
      sharedPreferences!.setString("token", jsonDecode(res.body)["data"]["token"]);
      Get.offAllNamed(AppRoutes.HOME);
      Get.snackbar("Success!", "Login Success", backgroundColor: Colors.green);
    }else{
      Get.snackbar("Error!", "invalid credentials!", backgroundColor: Colors.red);
    }
    isLogin.value = false;
  }


  //get my profile
  getMyProfile()async{
    var res = await ApiService().getApi(AppConfig.MY_PROFILE);
    if(res.statusCode == 200){
      GlobalVariables.myProfile.value = MyProfileModel.fromJson(jsonDecode(res.body));
    }
  }






  //clear all input feild
  clearAllInputFeild(){

  }

  selectedProfileType(index) {
    // Clear previous selections and add the new one
    print("Tapped on ${accountTypeName[index]}"); // Debug print
    selectedAccountType.clear();
    selectedAccountType.add(accountTypeName[index]);
    print("Selected Account Type: ${selectedAccountType}"); // Debug print
    update();
  }


  //logout
  logout()async{
    sharedPreferences!.clear();
    Get.offAllNamed(AppRoutes.LOGIN);
  }


}