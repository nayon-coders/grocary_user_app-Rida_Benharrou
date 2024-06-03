import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/model/user_model.dart';
import 'package:nectar/utility/app_const.dart';
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

  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  List accountType = ["Customer", "Seller", "Whole Seller"];
  List selectedType = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor:AppColors.bgWhite,
      body: SingleChildScrollView(
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
                    height: 80,
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //image: DecorationImage(image:AssetImage(Assets.loginbg),fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: Image.asset(Assets.logo, width: 300,),
                  ),
                  )
                ],
              ),
             Padding(
               padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 50),
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

                   Text("Choisir qui tu es ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    )
                   ),
                    SizedBox(height: 10,),

                    SizedBox(height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap:true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: accountType.length,
                        itemBuilder: (_, index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                selectedType.clear();
                                selectedType.add(accountType[index]);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:selectedType.contains(accountType[index])  ? AppColors.bgGreen : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: selectedType.contains(accountType[index]) ? Colors.white :   AppColors.bgGreen ,)
                                ),
                                child: Text(
                                  "I'am ${accountType[index]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                       fontSize: 12,
                                       color: selectedType.contains(accountType[index]) ? Colors.white :   AppColors.bgGreen
                                ),
                                )
                            ),
                          );
                        },
                      ),
                    ),
                   SizedBox(height: 20,),
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
                     ),
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
                    isLoading: _isLoading,
                     bgColor: AppColors.bgGreen,
                     name: "S'inscrire", onClick: (){
                       if(selectedType.isEmpty){
                         appSnackBar(context: context, text: "Veuillez choisir votre type de compte", bgColor: Colors.red);
                         return;
                       }
                       if(_key.currentState!.validate()){
                         int id = Random().nextInt(9999999);
                         var userModel = UserModel(
                           id: id.toString(),
                           email: _emailController.text,
                           name: _usernameController.text,
                           accountType: selectedType[0],
                         );
                         AuthController.userRegistration(context: context, userModel: userModel, pass: _passwordController.text);
                       }

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
    ),
    );
  }
}
