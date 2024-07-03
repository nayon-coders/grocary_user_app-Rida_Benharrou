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
                ShowHint(

                    hintText: "Ajoutez votre lieu de livraison maintenant.",
                    child:  InkWell(
                      onTap: (){

                       // EmailSendController.sendAdminEmail(orders: orders)

                      },
                     // onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),
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

            Categoreis(),
            SizedBox(height: 15,),
            //offer products
            OfferProducts(),
            SizedBox(height: 15,),
            SubCategoreis(),
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


