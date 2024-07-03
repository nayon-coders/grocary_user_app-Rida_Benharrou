import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key, required this.onClick, required this.name,
  });
  final VoidCallback onClick;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Color(0xffF2F3F2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.logout,color: AppColors.bgGreen,),
            SizedBox(width: 100,),
            Text(name,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.bgGreen),
            ),
          ],
        ),



      ),
    );
  }
}