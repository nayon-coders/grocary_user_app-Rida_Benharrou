import 'dart:convert';

import 'package:get/get.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/service/api.service.dart';

import '../../../data/models/product_model.dart';

class DetailsScreenController extends GetxController{


  Rx<SingleProduct> singleProduct = SingleProduct().obs;
  RxBool isLoading = false.obs;

  onInit(){
    super.onInit();

  }

  getSingleProductByID(id)async{
    isLoading.value = true;
    var res = await ApiService.getApi(AppConfig.PRPDUCT_SINGLE+"$id");
    if(res.statusCode == 200){
      print("single product response --- ${res.body}");
      singleProduct.value = SingleProduct.fromJson(jsonDecode(res.body)["data"]);
    }
    isLoading.value = false;
  }



  // getSingleProductByCategory()async{
  //   isLoading.value = true;
  //   var res = await ApiService.getApi(AppConfig.PRPDUCT_GET+"");
  //   if(res.statusCode == 200){
  //     singleProduct.value = SingleProduct.fromJson(jsonDecode(res.body));
  //   }
  //   isLoading.value = false;
  // }


  RxBool isGetRelatedProduct = false.obs;
  RxList<SingleProduct> relatedProduct = <SingleProduct>[].obs;

  getMainCatRelatedProduct(categoryName)async{
    isGetRelatedProduct.value = true;
    relatedProduct.value.clear(); //clear list
    var res = await ApiService.getApi(AppConfig.PRPDUCT_GET+"?category=$categoryName");
    var data = ProductListModel.fromJson(jsonDecode(res.body));
    if(res.statusCode == 200){
      for(var i in data.data!){
            relatedProduct.add(i);
          }
    }
    isGetRelatedProduct.value = false;
  }


}