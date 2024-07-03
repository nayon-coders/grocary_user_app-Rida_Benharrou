import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_network_images.dart';
import 'package:nectar/widget/app_shimmer.dart';

import '../../../model/sub_category_model.dart';
import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class Categoreis extends StatelessWidget {
  const Categoreis({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(categoryCollection).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
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

        //store category into category list
        List<CategoryModel> category = [];
        for(var i in snapshot.data!.docs){
          category.add(CategoryModel.fromSnapshot(i));
        }

        return category.isNotEmpty ? SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: category.length,
            itemBuilder: (context, index) {
              var data = category[index];
              return  InkWell(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(categoryName: data.categoryName!, fromSubCat: false, mainCatId: data.docId!, mainCatImage: data.categoryImage!, ))),
                child: Stack(
                  children:[
                    Container(
                      height: 200,
                      width: 150,
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
                          child: Center(child: AppNetworkImage(src: data.categoryImage!,))),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: SizedBox(
                          width: 130,
                          child: Center(child: Text("${data.categoryName!}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: AppColors.textBlack),))),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 7,
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


class SubCategoreis extends StatelessWidget {
  const SubCategoreis({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(subCategoryCollection).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
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

          //store category into category list
          List<SubCategoryModel> category = [];
          for(var i in snapshot.data!.docs){
            category.add(SubCategoryModel.fromJson(i));
          }

          return category.isNotEmpty ? Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Toute catégorie",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
                ],
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    var data = category[index];
                    return InkWell(
                     onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(categoryName: data.name!, mainCatId: data.docId!, mainCatImage: data.image!,  ))),
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 150,
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.grey.shade200)
                          ),
                        child: Column(
                          children: [

                            Text("${data.name}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                              ),
                            ),
                            Spacer(),
                            AppNetworkImage(src: data.image!, height: 80,),

                          ],
                        ),
                      ),
                    );

                  },
                ),
              ),
            ],
          )  : Center(child: Text("Category is empty"),);
        }
    );
  }
}
