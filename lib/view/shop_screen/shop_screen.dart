import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
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
  final List<Widget> images=[
    Image.asset(Assets.banner,height: 200,width:double.infinity,fit: BoxFit.cover,),
    Image.asset(Assets.slider2,height: 200,width:double.infinity,fit: BoxFit.cover,),
    Image.asset(Assets.slider1,height: 200,width:double.infinity,fit: BoxFit.cover,),

  ];
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
            Center(child: Image.asset(Assets.logo,height: 50,width:200,fit: BoxFit.contain,)),
            SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_channel_sharp,color: Colors.black,),
                  Text("Welcome to Commandespros",style:TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500,color: Colors.black),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            AppInput(
              controller: _search,
              prefixIcon: Icon(Icons.search,color: Colors.black,),
              hintText: "Search store",
            ),

            SizedBox(height: 5,),
            //sliders
            CarouserSlider(images: images),
            SizedBox(height: 15,),
            //category's
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


