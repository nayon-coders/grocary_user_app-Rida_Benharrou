import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
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
          Image.asset(AppAssets.loginbg,height: 200,width: double.infinity,fit: BoxFit.cover,),
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
            AppButton(name: "Suivre ma commande", onClick: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyOrders()), (route) => false)),
            SizedBox(height: 10,),
            TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen())), child: Text("Retour à la page d’accueil",
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
