import 'package:flutter/material.dart';
import 'package:nectar/controller/product_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/widget/app_shimmer.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import 'item_card.dart';


class NewItems extends StatelessWidget {
  const NewItems({super.key});

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
            Text("Nouveaux articles",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),

          ],
        ),
        SizedBox(height: 10,),
        StreamBuilder(
            stream: ProductController.getNewProduct(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                      padding: EdgeInsets.only(right: 10),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return AppShimmer();
                      }),
                );
              }

              //store data into product model list
              List<ProductModel> products = [];

              for(var i in snapshot.data!.docs){
                products.add(ProductModel.fromJson(i.data()));
              }

              print("products --- ${products.length}");

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 20.0,
                  mainAxisExtent: 230,
                ),
                itemCount: products.length > 8 ? 8 : products.length,
                itemBuilder: (context, index) {
                  return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                },
              );
            }
        ),
      ],
    );
  }
}
