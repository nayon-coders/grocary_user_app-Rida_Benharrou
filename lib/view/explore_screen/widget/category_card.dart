import 'package:flutter/material.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';
import 'package:nectar/view/explore_screen/widget/beverages_screen.dart';

import '../../../utility/app_color.dart';
import '../../../utility/assets.dart';
import '../../../utility/fontsize.dart';
class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>BeveragesScreen())),
      child: Container(
        padding: EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:AppColors.cardColor.withOpacity(.3),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.potato),fit: BoxFit.contain),

                ),
              ),

              SizedBox(height:20,),
              Center(
                child: SizedBox(
                  width: 100,
                  child: Text("Frash Fruits & Vegetable",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: normalFont,
                        color: Colors.black),
                  ),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}