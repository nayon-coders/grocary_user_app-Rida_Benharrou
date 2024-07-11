import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class AppField extends StatelessWidget {
  const AppField({super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 10),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w500,color:AppColors.textGrey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              ),
        ),

        validator: validator

      ),
    );
  }
}
