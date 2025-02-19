import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nectar/data/global/global_controller.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';

import '../../../app_config.dart';
import '../../../data/models/category_list_model.dart';
import '../../../data/models/category_product_model.dart';
import '../../../data/service/api.service.dart';
import '../../../main.dart';


class CategoryProductController extends GetxController{
  // Initialize a ScrollController
  final ScrollController scrollController = ScrollController();

  //home controller init 
  HomeController homeController = Get.find();


  RxString selectedMainCategory = "".obs;
  RxList<SingleCategory> subCategories =  <SingleCategory>[].obs;
  RxString selectedSubCategory = "".obs;
  RxInt mainCatIndex = 0.obs;





  GlobalController globalController = Get.put(GlobalController());
  // Rx<CategoryProductModel> catProductModel = CategoryProductModel().obs;
  Rx<ProductListModel> catProductModel = ProductListModel().obs;
  Rx<ProductListModel> searchProduct = ProductListModel().obs;
  RxBool isSubCatProduct = false.obs;

  RxBool isLoading = false.obs;


  getCategoryProduct() async {
    isLoading.value = true;
    try {
      if(selectedSubCategory.value == "All") {
        var res = await ApiService.getApi(
            AppConfig.PRPDUCT_GET + "?category=${selectedMainCategory.value}");
        if (res.statusCode == 200) {
          catProductModel.value =
              ProductListModel.fromJson(jsonDecode(res.body));
        } else {
          catProductModel.value = ProductListModel();
        }
      } else {
        var res = await ApiService.getApi(
            AppConfig.PRPDUCT_GET +
                "?category=${selectedMainCategory.value}&subcategory=${selectedSubCategory.value}");
        if (res.statusCode == 200) {
          catProductModel.value =
              ProductListModel.fromJson(jsonDecode(res.body));
        } else {
          catProductModel.value = ProductListModel();
        }
      }
    } catch (e) {
      print("error --- $e");
    } finally {
      isLoading.value = false;
    }
  }




  //auto point to the scroll
  // Method to scroll to the specific index
  void scrollToIndex() {
    double position = mainCatIndex.value * 100; // Assuming each item is approximately 100px wide. Adjust this as needed.
    scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500), // Duration of scroll animation
      curve: Curves.easeInOut, // Animation curve
    );
  }


  //get search product
  getSearchProduct(String searchValue) async {
    isLoading.value = true;
    print("search value --- $searchValue");
    try {
      var res = await ApiService.getApi("${AppConfig.BASE_URL}/product/all?name=${searchValue.toLowerCase()}");

      print("search product --- ${res.body}");

      if (res.statusCode == 200) {
        searchProduct.value =
            ProductListModel.fromJson(jsonDecode(res.body));
      } else {
        searchProduct.value = ProductListModel();
      }
    } catch (e) {
      print("error --- $e");
    } finally {
      isLoading.value = false;
    }
  }


}