import 'package:flutter/material.dart';

import '../../../utility/app_color.dart';
import '../../../utility/fontsize.dart';

class ListbottomSheet extends StatelessWidget {
  const ListbottomSheet({
    super.key, this.isOpen = true, required this.title, required this.subtitle, required this.onClick,
  });
  final String title;
  final Widget subtitle;
  final VoidCallback onClick;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
            style: TextStyle(
              fontSize: normalFont,
              fontWeight: FontWeight.w500,
              color: AppColors.textGrey,
            ),
          ),
          Row(
            children: [
              subtitle,
              SizedBox(width: 10,),
             isOpen ? Icon(Icons.keyboard_arrow_right,color: Colors.black,)  :Center(),

            ],
          )
        ],
      ),
    );
  }
}