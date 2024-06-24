import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/category_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/category_prodouct/category_product.dart';
import 'package:nectar/view/explore_screen/explore_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_network_images.dart';
import 'package:nectar/widget/app_shimmer.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class Categoreis extends StatelessWidget {
  const Categoreis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Catégorie's",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
            InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen(pageIndex: 1,))),
                child: Text("Voir tout",style: TextStyle(fontSize:smallFont,fontWeight: FontWeight.w600,color:AppColors.bgGreen),)),

          ],
        ),
        SizedBox(height: 10,),
        StreamBuilder(
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
              category.add(CategoryModel.fromJson(i.data()));
            }

            return category.isNotEmpty ? SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: category.length,
                itemBuilder: (context, index) {
                  var data = category[index];
                  return InkWell(
                    onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProduct(categoryName: data.categoryName!))),
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xffcadaca),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.grey.shade200)
                        ),
                      child: Column(
                        children: [

                          Text("${data.categoryName}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: 9,),
                          AppNetworkImage(src: data.categoryImage!, height: 100,),

                        ],
                      ),
                    ),
                  );
                },
              ),
            )  : Center(child: Text("Category is empty"),);
          }
        ),
      ],
    );
  }
}
