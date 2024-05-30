import 'package:flutter/material.dart';

class ProfileMenus extends StatelessWidget {
  const ProfileMenus({
    super.key, required this.text, required this.onClick, required this.icon,
  });

  final String text;
  final VoidCallback onClick;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey.shade300)
          )
      ),
      child: ListTile(
        onTap: onClick,
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon,color: Color(0xff181725),),
        title: Text("$text",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17
            )
        ),
        trailing: Icon(Icons.keyboard_double_arrow_right_outlined, size: 30,),
      ),
    );
  }
}