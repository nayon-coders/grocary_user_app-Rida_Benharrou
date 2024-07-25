import 'package:flutter/material.dart';
import '../utility/fontsize.dart';

class AppInput extends StatelessWidget {
  const AppInput({super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon, this.validator, this.onChanged, this.readOnly = false, this.onTap, this.maxLine = 1
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLine;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        maxLines: maxLine,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
          filled: true,
          fillColor: Color(0xFFF2F3F2),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w600,color: Colors.grey),
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          disabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),

      ),
    );
  }
}
