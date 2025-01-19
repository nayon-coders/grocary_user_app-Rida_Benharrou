import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../app_config.dart';
import '../../../data/models/fav_list_model.dart';
import '../../../data/service/api.service.dart';

class FavController extends GetxController {
  //inital
  @override
  void onInit() {
    super.onInit();
    getFavProduct();
  }

  //get fav product
  Rx<FavListModel> favProduct = FavListModel().obs;
  RxBool isLoading = false.obs;
  Future getFavProduct() async{
    isLoading.value = true;
    var res = await ApiService().getApi(AppConfig.FAVORITE_GET);
    if(res.statusCode == 200){
      favProduct.value = FavListModel.fromJson(jsonDecode(res.body));
    }else{
      favProduct.value = FavListModel();
    }
    isLoading.value = false;
  }

  //add fav product
  Future addFavProduct(id) async{
    var data = {
      "product_id": id
    };
    var res = await ApiService().postApi(AppConfig.FAVORITE_ADD, data);
    if(res.statusCode == 200){
      checkFavProduct(id);
      getFavProduct();
      Get.snackbar("Success!", "Product has been added to favourite", backgroundColor: Colors.green,colorText: Colors.white);
    }else{
      Get.snackbar("Error!", "Something went wrong", backgroundColor: Colors.red,colorText: Colors.black);
    }
  }

  //remove fav product
  Future removeFavProduct(id) async{
    var res = await ApiService().deleteApi(AppConfig.FAVORITE_REMOVE+id);
    if(res.statusCode == 200){
      checkFavProduct(id);
      getFavProduct();
      Get.snackbar("Success!", "Product has been removed from favourite", backgroundColor: Colors.green,colorText: Colors.white);
    }else{
      Get.snackbar("Error!", "Something went wrong", backgroundColor: Colors.red,colorText: Colors.black);
    }
  }

  //cehck fav product
  RxBool isFavProduct = false.obs;
  RxString selectedFavProductId = "".obs;
  checkFavProduct(id)async{
    var res = await ApiService().getApi(AppConfig.FAVORITE_CHECK+id);
    if(res.statusCode == 200) {
      if(jsonDecode(res.body)["favorite"] == false){
        isFavProduct.value = false;
      }else{
        isFavProduct.value = true;
      }
    }
  }
}