import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/category_prodouct/controller/category_product_controller.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';
import 'package:nectar/view/shop_screen/widget/categoreis.dart';

import '../../../data/models/category_list_model.dart';
import '../../../model/sub_category_model.dart';
import '../../../utility/app_color.dart';
import '../../../widget/app_network_images.dart';

class MainCatView extends GetView<CategoryProductController> {
   MainCatView({super.key});

  HomeController homeController = Get.find();



  @override
  Widget build(BuildContext context) {
    // Add a delay to ensure the ListView is built before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollToIndex(); // Scroll to the 5th index (0-based, so index 5 is actually the 6th item)


    });
    return Container(
      height: 45,
      color: Colors.white38,
      child: Obx((){
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: controller.scrollController, // Assign the ScrollController
          itemCount: homeController.categoryListModel!.value.data!.length ?? 1,
          itemBuilder: (_, index){


            return  Obx(() {
              return Container(
                height: 45,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedMainCategory.value == homeController.categoryListModel!.value.data![index].name.toString() ? AppColors.bgGreen.withOpacity(0.3) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  //  border: Border.all(color: AppColors.bgGreen, width: 1),
                ),
                child: InkWell(
                  onTap: (){
                    // Clear selected subcategory and set main category
                    controller.selectedSubCategory.value = "";
                    controller.selectedMainCategory.value = homeController.categoryListModel!.value.data![index].name!.toString();
                    // Fetch subCategories and ensure "All" is not already in the list
                    controller.subCategories.value = homeController.categoryListModel!.value.data![index].subCategories!;

                    // Dynamically set the first subcategory as the default
                    if(controller.subCategories.value.isNotEmpty){
                      controller.selectedSubCategory.value = homeController.categoryListModel!.value.data![index].subCategories!.first.name!.toString();
                    }


                    // Initialize call to get products
                    controller.getCategoryProduct();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppNetworkImage(src: homeController.categoryListModel!.value.data![index].image!, width: 50, height: 50,),
                      Text(homeController.categoryListModel!.value.data![index].name!, style: TextStyle(
                          color:  controller.selectedMainCategory.value == homeController.categoryListModel!.value.data![index].name.toString() ? AppColors.bgGreen : AppColors.bgGreen,
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                ),
              );
            }
            );
          },
        );
      }
      ),
    );
  }
}
