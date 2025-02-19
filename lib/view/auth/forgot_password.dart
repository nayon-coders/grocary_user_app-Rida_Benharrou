
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/view/auth/controller/forgot_controller.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';

import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({super.key});

   final ForgotController controller = Get.find<ForgotController>();
  final _emailController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInScreen())),
                  child: Container(
                    padding: EdgeInsets.all(10),
                     height: 50,
                     width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.bgGreen,
                    ),
                    child: const Center(child: Icon(Icons.keyboard_arrow_left,size:30,color: Colors.white,)),
                  ),
                ),
                const SizedBox(height: 70,),
                Text("Mot de passe oublié",
                  style: TextStyle(
                    fontSize: bigFont,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: 10,),
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
                const SizedBox(height: 40,),
                AppInput(controller: _emailController, hintText: "E-mail",
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Indiquez votre Email";
                        } else {
                          return null;
                        }
                      }
                ),
                const SizedBox(height: 40,),
                Obx((){
                    return AppButton(
                      bgColor: AppColors.bgGreen,
                      name: "Continuer",
                      isLoading:controller.isLoading.value,
                      onClick: ()async{
                        if(_key.currentState!.validate()){
                          controller.sendOtp(_emailController.text);

                        }

                      },

                    );
                  }
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
