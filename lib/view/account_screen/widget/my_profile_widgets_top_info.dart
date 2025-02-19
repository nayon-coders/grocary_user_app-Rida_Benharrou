import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/account_screen/controller/acocunt_controller.dart';


class MyProfileInfoTopWidgets extends GetView<AccountController> {
  const MyProfileInfoTopWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.pink.shade100
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ravis de vous revoir,",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.pink,
                fontSize: 35
            ),
          ),
          Text("${controller.myProfile.value.company}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.pink),),
        ],
      ),
    );
  }
}

