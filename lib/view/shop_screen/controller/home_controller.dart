import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/data/models/product_model.dart';
import 'package:nectar/data/service/api.service.dart';

import '../../../data/global/global_controller.dart';
import '../../../data/models/category_list_model.dart';
import '../../../main.dart';

class HomeController extends GetxController{

  var globalController = Get.put(GlobalController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllProduct();
    getAllCategory();
  }


  @override
  void onClose() {
    super.onClose();
    // Remove "All" from the list when closing
    subCategories.removeWhere((category) => category.name == 'All');
  }

  //get all products 
  Rx<ProductListModel> productListModel = ProductListModel().obs;
  RxList<SingleProduct> productList = <SingleProduct>[].obs;
  RxList<SingleProduct> promosProduct = <SingleProduct>[].obs;


  RxBool isLoading = false.obs;
  getAllProduct()async{
    isLoading.value = false;


    promosProduct.clear();

    var res = await ApiService().getApi(AppConfig.PRPDUCT_GET);

    if(res.statusCode == 200){
      //clear lists
      productList.value.clear();
      productListModel.value = ProductListModel.fromJson(jsonDecode(res.body));
      print("Product List: ${productListModel.value.data!.length}");
      for(var i in productListModel.value.data!){
        globalController.priceCalculat(i.regularPrice, i.sellingPrice, i.wholePrice, i.supperMarcent); //calculate price
        globalController.calculate(i); //calculate price
        if(i.status!.toLowerCase().contains("active")){
          productList.add(i);
        }
        if(i.discountPrice != null && i.discountPrice > 0){
          promosProduct.add(i);
        }
      }
    }
    isLoading.value = false;
  }



  //get all category
  Rx<CategoryListModel> categoryListModel = CategoryListModel().obs;
  RxList<SingleCategory> subCategories =  <SingleCategory>[].obs;
  RxBool isGettingCategory = false.obs;

  getAllCategory()async{
    isGettingCategory.value = true;
    subCategories.clear();
    var response = await ApiService().getApi(AppConfig.CATEGORY_GET);
    if(response.statusCode == 200){
      categoryListModel.value = CategoryListModel.fromJson(jsonDecode(response.body));
      for(var cat in categoryListModel.value.data!){
        if(cat.subCategories!.isNotEmpty){
          for(var subCat in cat.subCategories!){
            subCategories.add(subCat);
          }
        }
      }
    }
    isGettingCategory.value = false;
  }

}