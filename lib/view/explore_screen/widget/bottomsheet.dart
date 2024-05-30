
import 'package:flutter/material.dart';
import 'package:nectar/utility/fontsize.dart';

import '../../../utility/app_color.dart';

void bottomShit(BuildContext context,bool value,) {
  showBottomSheet(context: context, builder: (context){
    return Container(
      padding: EdgeInsets.all(15),
      color: Color(0xffF2F3F2),
      child: Column(
        children: [
          Text("Categories",
            style: TextStyle(
                fontSize: bigFont,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,),
          ),
          Checkbox(value: value, onChanged: (va){
            
          })
        ],
      ),
    );
  });
}