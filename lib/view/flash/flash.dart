import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';

import '../../utility/app_color.dart';
import '../../utility/assets.dart';
import '../auth/login_screen.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
     FirebaseAuth.instance.currentUser != null
         ?  Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen()))
         :  Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //backgroundColor: AppColors.bgGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.logo,height: 200,width: double.infinity,),
        ],
      ),
    ));
  }
}
