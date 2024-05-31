import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key,});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _initial = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      backgroundColor:AppColors.bgWhite,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                    ),
                    image: DecorationImage(image: AssetImage(Assets.potato,),fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black
                            ),
                            child: Center(child: Icon(Icons.keyboard_arrow_left,color: Colors.white,)))),
                    Icon(Icons.file_upload_outlined,color: Colors.black,),
                  ],
                
                ),)
                
              ],
            ),
            ///TODO:Product name
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pomme Rouge Naturelle",
                  style: TextStyle(
                      fontSize: titleFont,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Icon(Icons.favorite_border,color: AppColors.textGrey,),
              ],
            ),
            SizedBox(height: 5,),
            Text("prix 1kg",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: smallFont,
                  color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            _initial--;
                          });
                        },
                          child: Icon(Icons.remove,color: AppColors.textGrey,)),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.textGrey,width: .9),
                        ),
                        child: Center(
                          child: Text("${_initial}",style: TextStyle(fontSize: titleFont,color: Colors.black,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      InkWell(
                         onTap: (){
                           setState(() {
                             _initial++;
                           });
                         },
                          child: Icon(Icons.add,color: AppColors.bgGreen,))
                
                    ],
                  ),
                ),
                Text("\$4.99",style: TextStyle(fontWeight: FontWeight.w600,fontSize: titleFont,color: Colors.black),)
                
              ],
            ),
            SizedBox(height: 15,),
            ExpansionTile(
                title:Text("détails du produit"),
              children: [
                Text("Les pommes sont nutritives. Les pommes peuvent être "
                    "bonnes pour perdre du poids. les pommes peuvent être bonnes "
                    "pour votre cœur. Dans le cadre d'une alimentation saine et variée.")
              ],
            ),
           const ExpansionTile(title: Text("Nutrition")),
            ExpansionTile(
              title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Revoir"),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.orangeAccent,size: 15,),
                      Icon(Icons.star,color: Colors.orangeAccent,size: 15,),
                      Icon(Icons.star,color: Colors.orangeAccent,size: 15,),
                
                    ],
                  ),
                ],
                
              ),
            ),
                
                
            /// TODO:Product price
                
            ///TODO:product quantity and buy button
                
                
            /// TODO:payment method
          ],
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(30.0),
        child: AppButton(
          bgColor: AppColors.bgGreen,
          name: "Ajouter au panier",
          onClick: (){

          },
        ),
      ),
    ));
  }
}
