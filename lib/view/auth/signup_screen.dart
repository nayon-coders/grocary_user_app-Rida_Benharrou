import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/auth/widget/app_field.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor:AppColors.bgWhite,
      body: SingleChildScrollView(
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
                 Text("S'inscrire",
                   style: TextStyle(
                     fontWeight: FontWeight.w600,
                     fontSize: bigFont,
                     color: AppColors.textBlack,
                   ),
                 ),
                 SizedBox(height: 5,),
                 Text("Entrez vos identifiants pour continuer",
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: smallFont,
                     color: AppColors.textGrey,
                   ),
                 ),
                 SizedBox(height: 30,),
                 Text("Nom d'utilisateur",
                   style: TextStyle(
                       fontSize: normalFont,
                       fontWeight: FontWeight.w500,
                       color: AppColors.textGrey),),
                 AppField(
                     controller: _usernameController,
                     hintText: "Nom d'utilisateur",
                 ),
                 SizedBox(height: 20,),
                 Text("E-mail",
                   style: TextStyle(
                       fontSize: normalFont,
                       fontWeight: FontWeight.w500,
                       color: AppColors.textGrey),),
                 AppField(
                   controller: _emailController,
                   hintText: "E-mail",
                   suffixIcon: Icon(Icons.check,color: AppColors.bgGreen,),),
                 SizedBox(height: 20,),
                 Text("Mot de passe",
                   style: TextStyle(fontSize: normalFont,
                       fontWeight: FontWeight.w500,
                       color: AppColors.textGrey),),
                 AppField(
                   controller: _passwordController,
                   hintText: "Mot de passe",
                   suffixIcon: Icon(Icons.remove_red_eye,color: AppColors.textGrey,),),
                 SizedBox(height: 20,),
                 SizedBox(
                   width: 270,
                   child: RichText(text: TextSpan(
                       text: "En continuant, vous acceptez notre ",
                       style: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w500,color:AppColors.textGrey),
                       children: [
                         TextSpan(
                             text: "Conditions d'utilisation",
                             style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.bgGreen)
                         ),
                         TextSpan(
                             text: " et",
                             style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.textGrey)
                         ),
                         TextSpan(
                             text: " politique de confidentialité",
                             style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.bgGreen)
                         ),
                       ]
                   )),
                 ),
                 SizedBox(height: 40,),
                 AppButton(
                   bgColor: AppColors.bgGreen,
                   name: "S'inscrire", onClick: (){
                   //Navigator.push(context, MaterialPageRoute(builder: (_)=>LogInScreen()));
                 },
                 ),
                 SizedBox(height: 20,),
                 Center(
                   child: InkWell(
                     onTap: ()=>
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>LogInScreen())),
                     child: RichText(text: TextSpan(
                         text: "Vous avez déjà un compte? ",
                         style: TextStyle(
                             fontSize: normalFont,
                             fontWeight: FontWeight.w500,
                             color: Colors.black),
                         children: [
                           TextSpan(
                               text: "Se connecter",
                               style: TextStyle(
                                 fontWeight: FontWeight.w500,
                                 fontSize: normalFont,
                                 color:AppColors.bgGreen,
                               )
                           )
                         ]
                     )),
                   ),
                 ),

               ],
             ),
           )




          ],
        ),
      ),
    ),
    );
  }
}
