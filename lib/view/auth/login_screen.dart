import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/view/auth/controller/auth_controller.dart';
import 'package:nectar/view/auth/signup_screen.dart';
import 'package:nectar/view/auth/widget/app_field.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';
import 'forgot_password.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  AuthController _authController = Get.put(AuthController());
  bool _obscureText = true;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    backgroundColor:AppColors.bgWhite,
    
    body: SafeArea(
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(image:AssetImage(AppAssets.loginbg),fit: BoxFit.cover),
                    ),
                  ),
                  Image.asset(
                      AppAssets.logo,
                      height: 60,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
      
      
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Se connecter",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: bigFont,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("indiquez votre email et votre mot de passe",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: smallFont,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("E-mail",
                    style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w600,color: AppColors.textGrey),),
                  AppField(
                      controller: _authController.email.value,
                      hintText: "Email",
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Indiquez votre Email"; // Return a String for validation error
                      }
                      // Return null if input is valid
                      return null;
                    },
      
                  ),
                  SizedBox(height: 20,),
                  Text("Mot de passe",
                    style: TextStyle(fontSize: normalFont,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey,
                    ),),
                    AppField(
                        controller: _authController.pass.value,
                        hintText: "Mot de passe",
                        obscureText: _obscureText,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Indiquez votre Mot de passe";
                          }else{
                            return null;
                          }
                        },
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _obscureText = !_obscureText;
                            });
      
                          },
                          icon: Icon(_obscureText ? Icons.remove_red_eye : Icons.visibility_off,color: AppColors.textGrey,),
                        )),
                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotPassword())),
                      child: Text("Mot de passe oublié?",
                        style: TextStyle(fontSize: normalFont,
                            fontWeight: FontWeight.w500,
                            color:Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Obx(() {
                      return AppButton(
                        bgColor: AppColors.bgGreen,
                        name: "Se connecter",
                        isLoading: _authController.isLogin.value,
                        onClick: ()async{
                          if(_key.currentState!.validate()){
                           await _authController.login();
                          }
                        },
                      );
                    }
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: InkWell(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen())),
                      child: RichText(text: TextSpan(
                          text: "Vous n'avez pas encore de compte? ",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
                          children: [
                            TextSpan(
                                text: "S’inscrire",
                                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color:AppColors.bgGreen)
                            )
                          ]
                      )),
                    ),
                  )
                ],),
              ),
            ],
          ),
        ),
      ),
    ),
        );
  }
}
