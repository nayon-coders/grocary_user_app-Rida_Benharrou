import 'package:flutter/material.dart';
import 'package:nectar/view/detail_screen/detail_screen.dart';

import '../../../utility/app_color.dart';
import '../../../utility/assets.dart';
import '../../../utility/fontsize.dart';
class ItemCard extends StatelessWidget {
  const ItemCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Image.asset(Assets.potato,height:90,width:double.infinity,fit: BoxFit.contain,),
            SizedBox(height: 20,),
            Text("Potato",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: normalFont,
                  color: Colors.black),
            ),
            Text("1kg",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: smallFont,
                  color: Colors.black),
            ),
            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("৳50",
                  style: TextStyle(
                      fontSize: normalFont,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                InkWell(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailScreen())),
                  child: Container(
                     height: 40,
                     width: 40,
                    padding: EdgeInsets.only(left: 5,right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.bgGreen,
                    ),
                    child: Center(child: Icon(Icons.add,color: Colors.white,)),
                  ),
                )

              ],
            ),

          ],
        ),
      ),
    );
  }
}