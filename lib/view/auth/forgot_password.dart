import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/auth/signup_screen.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _emailController = TextEditingController();

  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor:Colors.white,

        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(10),
                     height: 50,
                     width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bgGreen,
                    ),
                    child: Center(child: Icon(Icons.keyboard_arrow_left,size:30,color: Colors.white,)),
                  ),
                ),
                SizedBox(height: 150,),
                Text("Mot de passe oublié",
                  style: TextStyle(
                    fontSize: bigFont,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                    width: 300,
                    child: Text("Veuillez saisir l'adresse e-mail à "
                        "laquelle vous souhaitez que les informations de "
                        "réinitialisation de votre mot de passe soient envoyées",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: smallFont,
                        color: AppColors.textGrey,
                      ),)
                ),
                SizedBox(height: 40,),
                AppInput(controller: _emailController, hintText: "E-mail",
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Indiquez votre Email";
                        } else {
                          return null;
                        }
                      }
                ),
                SizedBox(height: 40,),
                AppButton(
                  bgColor: AppColors.bgGreen,
                  name: "Continuer", isLoading: _isLoading, onClick: ()=> resetPasswordPressed(_emailController.text),

                ),




              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isLoading = false;
  // Example button press handler
  void resetPasswordPressed(String email)async {

    if(_key.currentState!.validate()){
      print("email --- $email");
      setState(() => _isLoading = true);
      await AuthController.resetPassword(email)
          .then((_) => {
        // Show success message or navigate to a success screen
        appSnackBar(context: context, text: "nous envoyons un e-mail de réinitialisation du mot de passe dans votre e-mail.", bgColor: Colors.green), 
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LogInScreen()), (route) => false)

      })
          .catchError((error) {
        // Handle errors (e.g., email not found, etc.)
        print("Password reset failed: $error");
        appSnackBar(context: context, text: "${error}", bgColor: Colors.red);
        // Show appropriate error message to the user
      });
      setState(() => _isLoading = false);

    }


  }
}
