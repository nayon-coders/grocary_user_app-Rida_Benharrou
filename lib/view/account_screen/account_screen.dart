

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/delivery_address/address_list.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/account_screen/widget/button.dart';
import 'package:nectar/view/account_screen/widget/profile_menus.dart';
import 'package:nectar/view/auth/login_screen.dart';

import '../../utility/app_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(Assets.man),fit: BoxFit.cover),
                  ),

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Chakib KB",style: TextStyle(fontSize: titleFont,color: Colors.black),),
                        SizedBox(width: 6,),
                        Icon(Icons.edit,color: Colors.green,)
                      ],
                    ),
                    Text("shakib.app.dev@gmail.com",style: TextStyle(fontSize: smallFont,color: AppColors.textGrey),),

                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            ProfileMenus(
              text: "Ordres",
              icon: Icons.shopping_bag_outlined,
              onClick: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));
              },
            ),
            ProfileMenus(
              text: "Mes Details",
              icon: Icons.perm_identity,
              onClick: (){},
            ),
            ProfileMenus(
              text: "Adresse de livraison",
              icon: Icons.location_on_outlined,
              onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),
            ),
            ProfileMenus(
              text: "Aide",
              icon: Icons.help_outline_outlined,
              onClick: (){},
            ),
            ProfileMenus(
              text: "À propos de nous",
              icon: Icons.info_outline,
              onClick: (){},
            ),
          ],
        ),
      ),
      bottomNavigationBar: SignOutButton(
        name:"Se déconnecter",
        onClick: ()=>Navigator.pop(context),
      ),
    ));
  }
}



