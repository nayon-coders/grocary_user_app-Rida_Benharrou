import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/account_screen/controller/acocunt_controller.dart';

import '../../utility/app_color.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final AccountController accountController = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        title: Text("Politique de confidentialité"),
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back,color:AppColors.textBlack,size: 30,)),

      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Politique de confidentialité",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                )
            ),
            SizedBox(height: 20,),
            Text("${accountController.pageModel.value.data!.privacy}",
                style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 1.1,
                    wordSpacing: 1.3,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                )
            )
          ],
        ),
      )

    );
  }
}
