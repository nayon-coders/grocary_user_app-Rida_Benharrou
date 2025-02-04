import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/routes/app_routes.dart';

import '../../../app_config.dart';
import '../../../data/service/api.service.dart';


class ForgotController extends GetxController{

  RxBool isLoading = false.obs;



   sendOtp(String email)async{
    isLoading.value = true;
    try{
      final res = await ApiService.postApi(
          AppConfig.FORGOT_PASSWORD,
          {"email":email}
      );
      if(res.statusCode ==200){
        print("otp send success");
        Get.snackbar("Bravo!", "Nous vous avons envoyé votre code d'authentification par email",
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
        Get.toNamed(AppRoutes.otpVerify,
          arguments: email,
        );

      }else{
        print("OTP send Failed ${jsonDecode(res.body)["message"]}");
        Get.snackbar("Erreur", "Adresse email erronée. Merci d'indiquer une adresse email valide.", backgroundColor: Colors.red,colorText: Colors.white);
      }
    }catch(e){
      print(e);
    }finally{
      isLoading.value = false;
    }

  }

  verifyOtp(String email, String otp)async{
    isLoading.value = true;
    try{
      final res = await ApiService.postApi(AppConfig.VERIFY_CODE,
          {
            "email":email,
            "resetCode":otp,
          });
      if(res.statusCode == 200){
        print("OTP verify Successful");
        Get.snackbar("Bravo ", "Opération réussie",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offNamed(
            AppRoutes.newPassword,
            arguments: {
              "email":email,
              "otp":otp,
            }
        );

      }else{
        print("OTP verify failed");
        Get.snackbar("Erreur ", "La vérification OTP a échoué",backgroundColor: Colors.red,colorText: Colors.white);
      }
    }catch(e){print(e);
    }finally{
      isLoading.value = false;
    }

  }


  //Add new password
   createNewPassword(String email,String otp,String password)async{
    isLoading.value = true;
    try{
      final res = await ApiService.postApi(
           AppConfig.NEW_PASSWORD,
           {
            "email":email,
            "resetCode":otp,
            "newPassword":password,

          });
      if(res.statusCode == 200){
        print("set password success");
        Get.snackbar("Bravo ", " Votre mot de passe a bien été modifié.",backgroundColor: Colors.green,colorText: Colors.white);
         Get.offAllNamed(AppRoutes.LOGIN);
      }else{
        print("Set password Failed");
        Get.snackbar("Erreur ", "échec de définition du nouveau mot de passe",colorText: Colors.white,backgroundColor: Colors.red);
      }
    }catch(e){print(e);
    }finally{
      isLoading.value = false;
    }
  }




}