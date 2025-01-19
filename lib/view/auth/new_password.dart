import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/view/auth/controller/forgot_controller.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';
import '../../widget/app_input.dart';

class NewPassword extends StatelessWidget {
   NewPassword({super.key});

   final ForgotController controller = Get.find<ForgotController>();
  final newPassword = TextEditingController();
  final confPassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //get email & otp form otp screen
    final Map<String,dynamic> arg = Get.arguments;
    final String email = arg["email"];
    final String otp = arg["otp"];
    print("argument otp-------$email----------");
    print("argument otp-------$otp----------");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding:const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
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
                const Text("Create new password",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),

                const SizedBox(height: 10,),
                const SizedBox(
                  width: 300,
                  child: Text("Your new password must be unique from those previously used.",style: TextStyle(
                    fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.textGrey,
                  ),
                  ),
                ),
                const SizedBox(height: 30,),
                AppInput(
                  hintText: "New Password",
                  controller: newPassword,

                ),
                const SizedBox(height: 15,),
                AppInput(
                  hintText: "Conform Password",
                  controller: confPassword,

                ),
                const SizedBox(height: 30,),
                Obx(() {
                  return AppButton(
                    isLoading: controller.isLoading.value,
                      name: "Reset Password",
                      onClick: ()async{
                        if(newPassword.text == confPassword.text){
                          controller.createNewPassword(
                            email,
                            otp,
                            newPassword.text,
                          );
                        }else{
                          Get.snackbar("Failed", "Passwords do not match",backgroundColor: Colors.red);
                        }


                      }
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
