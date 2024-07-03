import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';
import '../../../utility/assets.dart';
import '../../../utility/fontsize.dart';
class GroceriesCard extends StatelessWidget {
  const GroceriesCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
       padding: EdgeInsets.all(10),
      // height: 50,
       width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:AppColors.cardColor.withOpacity(.2),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.dal,height:50,width:90,fit: BoxFit.contain,),
            SizedBox(height: 5,),
            Text("Les légumineuses",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: titleFont,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}