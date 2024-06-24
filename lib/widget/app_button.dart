import 'package:flutter/material.dart';
import '../utility/app_color.dart';
import '../utility/fontsize.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key,
    required this.name,
    required this.onClick,
    this.bgColor=AppColors.bgGreen,
    this.textColor = Colors.white,
    this.isLoading = false
  });
  final String name;
  final VoidCallback onClick;
  final Color bgColor;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 20, right: 20,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Center(
          child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text(name,
            style: TextStyle(
              fontSize: normalFont,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
