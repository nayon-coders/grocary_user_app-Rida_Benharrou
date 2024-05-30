import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class AppField extends StatelessWidget {
  const AppField({super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 10),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w500,color:AppColors.textGrey),
          border:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder:   UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder:   UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),

      ),
    );
  }
}