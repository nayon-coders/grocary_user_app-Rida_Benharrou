

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/about_us.dart';
import 'package:nectar/view/account_screen/delivery_address/address_list.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/account_screen/widget/button.dart';
import 'package:nectar/view/account_screen/widget/profile_menus.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';
import 'package:nectar/widget/app_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FutureBuilder(
                future: AuthController.getMyInfo(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center();
                  }
                  return Container(
                    height: 200,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.pink.shade100
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome back,",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                            fontSize: 35
                          ),
                        ),
                        Text("${snapshot.data!.docs[0].data()["name"]}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.pink),),
                      ],
                    ),
                  );
                }
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My Action",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Ordres",
                        icon: Icons.shopping_bag_outlined,
                        onClick: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));
                        },
                      ),

                      ProfileMenus(
                        text: "Adresse de livraison",
                        icon: Icons.location_on_outlined,
                        onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),
                      ),
                      ProfileMenus(
                        text: "Favorite",
                        icon: Icons.favorite_border,
                        onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>NavigationScreen(pageIndex: 3,))),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Legal",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Contactez-nous",
                        icon: Icons.help_outline_outlined,
                        onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/contactez-nous")),
                      ),
                      ProfileMenus(
                        text: "Termes et Conditions",
                        icon: Icons.info_outline,
                        onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/conditions-generales-de-vente/")),
                      ),
                      ProfileMenus(
                        text: "Politique de Confidentialité",
                        icon: Icons.info_outline,
                        onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/politique-de-confidentialite/")),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account Management",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Delete account",
                        icon: Icons.delete,
                        onClick: (){
                          AppDialog(
                              context,
                              "Es-tu sûr?",
                              "Es-tu sûr? Voulez-vous supprimer votre compte ?",
                                  () async{
                                await AuthController.deleteAccout(context);
                              }
                          );
                        },
                      ),
                    ],
                  ),




                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SignOutButton(
        name:"Se déconnecter",
        onClick:(){
          AppDialog(
              context,
              "Es-tu sûr?",
              "Es-tu sûr? Voulez-vous vous déconnecter?",
                  () async{
                await AuthController.logOut(context);
              }
          );
        },
      ),
    ));
  }



  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}



