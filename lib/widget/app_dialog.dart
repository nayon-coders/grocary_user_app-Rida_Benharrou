import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';

import '../utility/app_color.dart';

void AppDialog(BuildContext context, String title, String subtitle, VoidCallback onYes ){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      scrollable: true,
      title: Text(title,
        style: TextStyle(
          fontSize: titleFont,
            fontWeight: FontWeight.w600),
      ),
      content: Text(subtitle,
        style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500),
      ),
      actions: [
        TextButton(onPressed: onYes, child: Text("YES")),
        SizedBox(width: 20,),
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("NO")),
      ],

    );
  });

}