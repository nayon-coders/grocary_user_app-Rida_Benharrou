import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_config.dart';
import '../../../data/service/api.service.dart';
import '../../../data/models/delivery_address_model.dart';

class AddressControllerNew extends GetxController {
  //inital
  @override
  void onInit() {
    super.onInit();
    getAddress();
    getPostCode();
  }

  //address model
   Rx<DeliveryAddressModel> address = DeliveryAddressModel().obs;

  RxBool isLoading = false.obs;

  //get address data
   getAddress() async{
    isLoading.value = true;
    var res = await ApiService.getApi(AppConfig.DELIVERY_ADDRESS);
    if(res.statusCode == 200){
      address.value = DeliveryAddressModel.fromJson(jsonDecode(res.body));
    }
    isLoading.value = false;
  }



  //add address
  Rx<TextEditingController> addressText = TextEditingController().obs;
  Rx<TextEditingController> villeText = TextEditingController().obs;
  Rx<TextEditingController> messageText = TextEditingController().obs;
  Rx<TextEditingController> contactText = TextEditingController().obs;
  Rx<TextEditingController> phoneText = TextEditingController().obs;
  Rx<String> postCodeText = "".obs;
  Future addAddress() async{
    isLoading.value = true;
     var data ={
       "phone": phoneText.value.text,
       "contact": contactText.value.text,
       "address": addressText.value.text,
       "address_type": "home",
       "city": villeText.value.text,
       "post_code": postCodeText.value,
       "message": messageText.value.text
     };

     print("data --- ${data}");
    var res = await ApiService.postApi(AppConfig.DELIVERY_ADDRESS_ADD, data);
    if(res.statusCode == 200){
      Get.back();
      Get.snackbar("Bravo!", "Nouvelle adresse bien ajoutée", backgroundColor: Colors.green,colorText: Colors.white);
      getAddress();
      clearTextField();

    }else{
      Get.snackbar("Désolé!", "Merci de vérifier vos informations", backgroundColor: Colors.red,colorText: Colors.white);
    }
    isLoading.value = false;
  }

  //get all post code
  RxList<String> postCodeList = <String>[].obs;
  RxBool isGettingPostCode = false.obs;
  Future getPostCode()async{
    isGettingPostCode.value = true;
    var res = await ApiService.getApi(AppConfig.POST_CODE_GET);
    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      for(var i in data["data"]){
        postCodeList.add(i["code"]);
      }
    }
    isGettingPostCode.value = false;
  }


  //delete address
   deleteAddress(id) async{
    isLoading.value = true;
    var res = await ApiService.deleteApi(AppConfig.DELIVERY_ADDRESS_delete+id);
    if(res.statusCode == 200){

      getAddress();
      print("delevery address delete success");
      Get.back();
      Get.snackbar("Bravo!", "L'adresse a bien été supprimée", backgroundColor: Colors.green,colorText: Colors.white);



    }else{
      Get.snackbar("Désolé!", "Merci de vérifier vos informations", backgroundColor: Colors.red,colorText: Colors.white);
    }
    isLoading.value = false;
  }

  //update address
  Future updateAddress(id) async{
    isLoading.value = true;
    var data ={
      "phone": phoneText.value.text,
      "contact": contactText.value.text,
      "address": addressText.value.text,
      "address_type": "home",
      "city": villeText.value.text,
      "post_code": postCodeText.value,
      "message": messageText.value.text
    };

    var res = await ApiService.putApi(AppConfig.DELIVERY_ADDRESS_UPDATE+id, data);
    if(res.statusCode == 200){
      Get.back();
      Get.snackbar("Bravo!", "L'adresse a été mise à jour", backgroundColor: Colors.green,colorText: Colors.white);
      getAddress();
      clearTextField();


    }else{
      Get.snackbar("Désolé!", "Merci de vérifier vos informations", backgroundColor: Colors.red,colorText: Colors.white);
    }
    isLoading.value = false;
  }


  //clear text field
  void clearTextField(){
    addressText.value.clear();
    villeText.value.clear();
    messageText.value.clear();
    contactText.value.clear();
    phoneText.value.clear();
    postCodeText.value = "";
  }
}