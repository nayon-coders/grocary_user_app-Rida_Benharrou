import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/category_prodouct/controller/category_product_controller.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';

import '../../../utility/app_color.dart';
import '../../../widget/app_network_images.dart';

class SubCatView extends GetView<CategoryProductController> {
  SubCatView({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 35,
        color: Colors.white38,
        child: controller.selectedSubCategory.value.isEmpty ? Center(child: Text("No Sub Category"),) : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.subCategories.length,
          itemBuilder: (_, index){
            return   Obx(() {
                return Container(
                  margin: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: (){
                      controller.selectedSubCategory.value = controller.subCategories![index].name!.toString();

                      //init call get product
                      controller.getCategoryProduct();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                       // color: controller.selectedSubCategory.value == controller.subCategories![index].id.toString() ? AppColors.bgGreen : Colors.white,
                       // borderRadius: BorderRadius.circular(10),
                        border: controller.selectedSubCategory.value == controller.subCategories![index].name.toString() ? Border(bottom: BorderSide(width: 1, color: Colors.black)) : Border.all(width: 0, color: Colors.transparent),
                      ),
                      child: Text(controller.subCategories[index]!.name!, style: TextStyle(
                        fontSize: 17,
                          color:  controller.selectedSubCategory.value == controller.subCategories![index].name.toString() ? Colors.black : Colors.black45,
                          fontWeight: FontWeight.w400
                      ),),
                    ),
                  ),
                );
              }
            );
          },
        ),
      );
    }
    );
  }
}
