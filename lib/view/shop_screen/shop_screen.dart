import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/generated/assets.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/shop_screen/widget/best_selling_products.dart';
import 'package:nectar/view/shop_screen/widget/categoreis.dart';
import 'package:nectar/view/shop_screen/widget/groceries_card.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/view/shop_screen/widget/offer_products.dart';
import 'package:nectar/view/shop_screen/widget/recent_products.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../widget/slider.dart';

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
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///ToDo modify
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>MyOrders())),
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
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Text("10 Min",
                    style: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w400,color: AppColors.textBlack),),
                )
              ],
            ),
            SizedBox(height: 10,),
            ///TODO static image
            Stack(
                children:[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown.shade200,

                    ),
                      child: Image.asset("assets/images/foods.png",height: 130,width: 150,fit: BoxFit.cover,)),
                  Positioned(
                    left: 10,
                    top: 3,
                    child: SizedBox(
                      width: 130,
                        child: Text("Reccentes de la semains",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: AppColors.textBlack),)),
                  ),
                  Positioned(
                    right: 7,
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
            //Center(child: Image.asset(Assets.logo,height: 50,width:200,fit: BoxFit.contain,)),
            // SizedBox(height: 10,),
            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Icon(Icons.wifi_channel_sharp,color: Colors.black,),
            //       Text("Welcome to Commandespros",style:TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500,color: Colors.black),)
            //     ],
            //   ),
            // ),
            //SizedBox(height: 20,),
            // AppInput(
            //   controller: _search,
            //   prefixIcon: Icon(Icons.search,color: Colors.black,),
            //   hintText: "Search store",
            // ),

            //SizedBox(height: 5,),
            //sliders
            //CarouserSlider(images: images),
            SizedBox(height: 15,),

            Categoreis(),
            SizedBox(height: 15,),
            //offer products
            OfferProducts(),
            SizedBox(height: 15,),
            BestSellingProducts(),


            SizedBox(height: 15,),
            NewItems(),

          ],
        ),
      ),
    ));
  }
}


