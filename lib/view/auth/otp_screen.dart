import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:nectar/view/auth/controller/forgot_controller.dart';
import 'package:pinput/pinput.dart';

import '../../utility/app_color.dart';
import '../../widget/app_button.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

   final ForgotController controller = Get.find<ForgotController>();
  final _otpController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String email = Get.arguments as String;
    print("argument email -------$email------");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: ()=>Get.toNamed(AppRoutes.forgotScreen),
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
                ),
                const SizedBox(height: 70,),

                const Text("Vérification",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black),),

                const SizedBox(height: 10,),
                const SizedBox(
                  width: 300,
                  child: Text("Indiquez le code de vérification reçu par email.",style: TextStyle(
                    fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.textGrey,
                  ),
                  ),
                ),
                const SizedBox(height: 30,),
                Pinput(
                  controller: _otpController,
                  length: 6,
                  showCursor: true,
                  validator: (v){
                    if(v!.isEmpty){
                      return "Must be required";
                    }
                    return null;
                  },
                  onChanged: (pin)=>print("OTP Entered:$pin"),
                ),
                const SizedBox(height: 20,),
                Obx(() {
                    return AppButton(
                      isLoading: controller.isLoading.value,
                        name: "Valider",
                        onClick: ()async{
                          if(_key.currentState!.validate()){
                            controller.verifyOtp(email, _otpController.text);
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
