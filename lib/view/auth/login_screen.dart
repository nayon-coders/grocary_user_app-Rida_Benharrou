import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/utility/assets.dart';
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

      backgroundColor:AppColors.bgWhite,

      body: SingleChildScrollView(
        // padding: EdgeInsets.all(20),
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
                    image: DecorationImage(image:AssetImage(Assets.loginbg),fit: BoxFit.cover),
                  ),
                ),
                Image.asset(
                    Assets.gajorIcon,
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
                Text("Entrez vos emails et votre mot de passe",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: smallFont,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 30,),
                Text("E-mail",
                  style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w600,color: AppColors.textGrey),),
                AppField(controller: _emailController, hintText: "Email"),
                SizedBox(height: 20,),
                Text("Mot de passe",
                  style: TextStyle(fontSize: normalFont,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey,
                  ),),
                AppField(
                  controller: _passwordController,
                  hintText: "Mot de passe",
                  suffixIcon: Icon(Icons.remove_red_eye,color: AppColors.textGrey,),
                ),
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotPassword())),
                    child: Text("Mot de passe oublié?",
                      style: TextStyle(fontSize: normalFont,
                          fontWeight: FontWeight.w500,
                          color:AppColors.textBlack),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                AppButton(
                  bgColor: AppColors.bgGreen,
                  name: "Se connecter", onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>NavigationScreen())),

                ),
                SizedBox(height: 20,),
                Center(
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen())),
                    child: RichText(text: TextSpan(
                        text: "Vous n'avez pas de compte ? ",
                        style: TextStyle(fontSize: normalFont,fontWeight: FontWeight.w500,color: Colors.black),
                        children: [
                          TextSpan(
                              text: "S'inscrire",
                              style: TextStyle(fontWeight: FontWeight.w500,fontSize: normalFont,color:AppColors.bgGreen)
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
    );
  }
}
