
import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';

import '../utility/app_color.dart';

void dialogBox(BuildContext context) {
  showDialog(context: context, builder: (BuildContext cobtex){
    return Dialog(
      
      child: Container(
        padding: EdgeInsets.all(15),
        height: 430,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:AppColors.bgWhite,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                    child: Icon(Icons.close,size:30,color:AppColors.textBlack,)),
              ),
              Center(child: Image.asset(Assets.dialog,height: 130,width:130,fit: BoxFit.contain,)),
              SizedBox(height: 10,),
              Text("Oops! Order Failed",
                style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack),
              ),
              SizedBox(height: 10,),
              Text("Something went temblor wrong.",
                style: TextStyle(fontWeight: FontWeight.w400,
                    fontSize: smallFont,
                    color: AppColors.textGrey),
              ),
              Spacer(),
              AppButton(name: "Please Try Again", onClick: (){}),
              SizedBox(height: 6,),
              Center(
                child: TextButton(
                    onPressed: (){},
                    child: Text("Back to home",
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                  ),
                    )),
              )
            ],
          ),
        ),

      ),
    );
  });
}