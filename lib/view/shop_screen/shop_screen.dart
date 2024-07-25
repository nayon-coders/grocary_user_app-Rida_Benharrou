import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/email_send_controller.dart';
import 'package:nectar/generated/assets.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/delivery_address/address_list.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/shop_screen/widget/best_selling_products.dart';
import 'package:nectar/view/shop_screen/widget/categoreis.dart';
import 'package:nectar/view/shop_screen/widget/groceries_card.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/view/shop_screen/widget/offer_products.dart';
import 'package:nectar/view/shop_screen/widget/recent_products.dart';
import 'package:nectar/widget/app_input.dart';
import 'package:nectar/widget/show_hint_widgets.dart';

import '../../controller/product_controller.dart';
import '../../model/product_model.dart';
import '../../utility/app_color.dart';
import '../../widget/app_shimmer.dart';
import '../../widget/slider.dart';
import '../show_product/all_products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final List<Widget> images=[
  //   Image.asset(Assets.banner,height: 200,width:double.infinity,fit: BoxFit.cover,),
  //   Image.asset(Assets.slider2,height: 200,width:double.infinity,fit: BoxFit.cover,),
  //   Image.asset(Assets.slider1,height: 200,width:double.infinity,fit: BoxFit.cover,),
  //
  // ];
  final _search =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      backgroundColor: AppColors.bgWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///ToDo modify
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShowHint(

                    hintText: "Ajoutez votre lieu de livraison maintenant.",
                    child:  InkWell(
                      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),

                      child: Row(
                        children: [
                          Text("Choisir une adresse",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                              fontSize: smallFont,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.keyboard_arrow_down,color: Colors.pink,),
                        ],
                      ),
                    ),
                ),


              ],
            ),
            SizedBox(height: 10,),
            ///TODO static image

            Categoreis(),
            SizedBox(height: 15,),
            //offer products
            OfferProducts(),

            SizedBox(height: 15,),
            //single category product 
            Container(
              height: 280,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink.shade50
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nouveauté",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: Colors.black),),
                      InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(title: "Nouveaux articles",))),
                          child: Container(
                              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Text("Voir tout",style: TextStyle(fontSize:13,fontWeight: FontWeight.w500,color:AppColors.bgGreen),))),

                    ],
                  ),
                  SizedBox(height: 10,),

                  StreamBuilder(
                      stream: ProductController.getNewProduct(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
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
              ),
            ),
           // NewItems(),
            SizedBox(height: 15,),
            SubCategoreis(),

          ],
        ),
      ),
    ));
  }
}


