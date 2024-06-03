import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';

import '../utility/app_color.dart';

void AppDialog({required BuildContext context,required String title,required String subtitle, required VoidCallback  onDelete}){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white,
      title: Text(title,
        style: TextStyle(
          fontSize: titleFont,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      content: Text(subtitle,
        style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500,color: Colors.black),
      ),
      actions: [
        SizedBox(
          width: 100,
          child: AppButton(

              name: "Delete",
              onClick: onDelete,
            bgColor: Colors.blue,
          ),
        ),
        SizedBox(width: 20,),
        SizedBox(
          width: 100,
          child: AppButton(
              name: "Cancel",
              textColor: Colors.black,
              onClick: ()=>Navigator.pop(context),
            bgColor: Colors.white,
          ),
        ),
      ],

    );
  });

}