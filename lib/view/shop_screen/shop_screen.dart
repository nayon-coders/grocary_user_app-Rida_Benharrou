import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/shop_screen/widget/groceries_card.dart';
import 'package:nectar/view/shop_screen/widget/item_card.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../widget/slider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
            Center(child: Image.asset(Assets.gajorIcon,height: 50,width:50,fit: BoxFit.contain,)),
            SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,color: Colors.black,),
                  Text("Dhaka, ville modèle verte",style:TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500,color: AppColors.textBlack),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            AppInput(
              controller: _search,
              prefixIcon: Icon(Icons.search,color: AppColors.textBlack,),
              hintText: "Rechercher un magasin",
            ),

            SizedBox(height: 5,),
            CarouserSlider(images: images),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Offre exclusive",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: AppColors.textBlack),),
                InkWell(
                  onTap: (){},
                    child: Text("Voir tout",style: TextStyle(fontSize:smallFont,fontWeight: FontWeight.w600,color:AppColors.bgGreen),)),

            ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 250,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 10),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return ItemCard();
                  }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Meilleure vente",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: AppColors.textBlack),),
                InkWell(
                  onTap: (){},
                    child: Text("Voir tout",style: TextStyle(fontSize:smallFont,fontWeight: FontWeight.w600,color:AppColors.bgGreen),)),

              ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return ItemCard();
                  }),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Épiceries",style: TextStyle(fontSize:titleFont,fontWeight: FontWeight.w600,color: AppColors.textBlack),),
                InkWell(
                    onTap: (){},
                    child: Text("Voir tout",style: TextStyle(fontSize:smallFont,fontWeight: FontWeight.w600,color:AppColors.bgGreen),)),

              ],
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return GroceriesCard();
                  }),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return ItemCard();
                  }),
            ),

          ],
        ),
      ),
    ));
  }
}


