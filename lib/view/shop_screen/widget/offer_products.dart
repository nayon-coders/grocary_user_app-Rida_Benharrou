import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/product_controller.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/view/show_product/all_products.dart';
import 'package:nectar/widget/app_shimmer.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';
import 'item_card.dart';


class OfferProducts extends StatelessWidget {
  const OfferProducts({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("Promos",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
            InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(title: "Offre exclusive",))),
                child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8,),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Text("Voir tout",style: TextStyle(fontSize:13,fontWeight: FontWeight.w500,color:AppColors.bgGreen),))),

          ],
        ),
        SizedBox(height: 10,),
        StreamBuilder(
          stream: ProductController.getOfferProduct(),
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

            return products!.isEmpty ? SizedBox(
                height:150, child: const Center(child: Text("We don't have any discount now."),)) : SizedBox(
              height: 200,
              child: ListView.builder(
                  padding: EdgeInsets.only(right: 10),
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                  }),
            );
          }
        ),
      ],
    );
  }
}



class NewProducts extends StatelessWidget {
  const NewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("New",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
            InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(title: "Offre exclusive",))),
                child: Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8,),
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Text("Voir tout",style: TextStyle(fontSize:13,fontWeight: FontWeight.w500,color:AppColors.bgGreen),))),

          ],
        ),
        SizedBox(height: 10,),
        StreamBuilder(
            stream: ProductController.getNewAll(),
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


              return SizedBox(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.only(right: 10),
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return products[index].status == "Active" ? ItemCard(productModel: products[index],) : Center();
                    }),
              );
            }
        ),
      ],
    );
  }
}

