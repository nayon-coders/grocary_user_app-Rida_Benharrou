import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/widget/app_button.dart';

import '../../utility/app_color.dart';
import '../../utility/assets.dart';

class OrderAccepted extends StatefulWidget {
  const OrderAccepted({super.key});

  @override
  State<OrderAccepted> createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends State<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.loginbg,height: 200,width: double.infinity,fit: BoxFit.cover,),
          Center(
            child: Lottie.asset("assets/animation/success.json",
            height:150,
            width: 200,
            fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 15,),
          SizedBox(
            width: 230,
            child: Text("Votre commande a été acceptée",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: bigFont,
                  color: AppColors.textBlack,
              ),
            ),
          ),
          SizedBox(height: 15,),
          SizedBox(
            width: 200,
            child: Text("Vos articles ont été placés et sont en cours de traitement",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: smallFont,
                  color: AppColors.textBlack,
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        height: 140,
        padding: EdgeInsets.all(10),

        child: Column(
          children: [
            AppButton(name: "Suivi de commande", onClick: (){}),
            SizedBox(height: 10,),
            TextButton(onPressed: ()=>Navigator.pop(context), child: Text("De retour à la maison",
              style: TextStyle(fontSize: normalFont,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBlack),
            ))

          ],
        ),
      ),
    ));
  }
}
