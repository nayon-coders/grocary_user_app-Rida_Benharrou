import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/app_config.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/view/shop_screen/controller/home_controller.dart';
import 'package:nectar/widget/app_network_images.dart';
import 'package:nectar/widget/app_shimmer.dart';
import 'package:nectar/widget/not_found.dart';

import '../../../model/sub_category_model.dart';
import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class Categoreis extends GetView<HomeController> {
  const Categoreis({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if(controller.isGettingCategory.value){
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              return AppShimmer();
            },
          );
        }

        return controller.categoryListModel.value.data!.isNotEmpty ? SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: controller.categoryListModel.value.data!.length,
            itemBuilder: (context, index) {
              var data = controller.categoryListModel.value.data![index];
              return  InkWell(
               // onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(categoryName: data.name!, fromSubCat: false, mainCatId: data.id.toString(), mainCatImage: data.image!, ))),
                child: Stack(
                  children:[
                    Container(
                      height: 160,
                      width: 160,
                      margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.shade100,
                        ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 15,
                      child: SizedBox(
                          width: 130,
                          child: Center(child: AppNetworkImage(src: data.image!, fit: BoxFit.contain,))),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: SizedBox(
                          width: 130,
                          child: Center(child: Text("${data.name!}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: AppColors.textBlack),))),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 15,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(Icons.keyboard_arrow_right,color: Colors.red,),
                      ),
                    )

                  ],
                ),
              );
              // return InkWell(
              //   onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(categoryName: data.categoryName!,  categoryProduct: data,))),
              //   child: Container(
              //     margin: EdgeInsets.only(right: 15),
              //     padding: EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         color: Color(0xffcadaca),
              //         borderRadius: BorderRadius.circular(5),
              //         border: Border.all(width: 1, color: Colors.grey.shade200)
              //       ),
              //     child: Column(
              //       children: [
              //
              //         Text("${data.categoryName}",
              //           style: TextStyle(
              //             fontSize: 13,
              //             fontWeight: FontWeight.w600,
              //             color: Colors.black
              //           ),
              //         ),
              //         SizedBox(height: 9,),
              //         AppNetworkImage(src: data.categoryImage!, height: 80,),
              //
              //       ],
              //     ),
              //   ),
              // );
            },
          ),
        )  : Center(child: Text("Category is empty"),);
      }
    );
  }
}


class SubCategoreis extends GetView<HomeController> {
  final bool showTitle;
  const SubCategoreis({super.key, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
          if(controller.isGettingCategory.value){
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return AppShimmer();
              },
            );
          }

          ///TODO: if need subcategory then just uncomment this block
          // //store category into category list
          // List<SubCategoryModel> category = [];
          // for(var i in snapshot.data!.docs){
          //   category.add(SubCategoryModel.fromJson(i));
          // }


          return controller.categoryListModel.value.data!.isNotEmpty ? Column(

            children: [
              showTitle ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Par catégorie",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
                ],
              ) : Center(),
              SizedBox(height: 15,),
              SizedBox(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                    mainAxisExtent: 170,
                  ),
                  itemCount:  controller.categoryListModel.value.data!.length,
                  itemBuilder: (context, index) {
                    var data = controller.categoryListModel.value.data![index];
                    return InkWell(
                      onTap: ()=>Get.to(CategoryProduct(categoryName: data.name!, subCategories:  data.subCategories!, mainCatIndex: index, subCatName: "All")),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.grey.shade200)
                        ),
                        child: Column(
                          children: [

                            SizedBox(
                              child: Text("${data.name}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                ),
                              ),
                            ),
                            Spacer(),
                            AppNetworkImage(src: data.image!, height: 110,),

                          ],
                        ),
                      ),
                    );
                  },
                ),

              ),
            ],
          )  : Center(child: NotFound(),);
        }
    );
  }
}
