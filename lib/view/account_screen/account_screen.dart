

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/about_us.dart';
import 'package:nectar/view/account_screen/delivery_address/address_list.dart';
import 'package:nectar/view/account_screen/delivery_address/delivery_address.dart';
import 'package:nectar/view/account_screen/my_orders/my_orders.dart';
import 'package:nectar/view/account_screen/privacy_policy.dart';
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
  final _auth =  FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            StreamBuilder(
              stream: _firestore.collection(usersCollection).where("email", isEqualTo: _auth.currentUser!.email).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: Colors.grey),
                       // shape: BoxShape.circle,
                        //image: DecorationImage(image: AssetImage(Assets.man),fit: BoxFit.cover),
                      ),
                      child: Icon(Icons.person),

                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${snapshot.data!.docs[0]["name"]}",style: TextStyle(fontSize: titleFont,color: Colors.black),),
                          ],
                        ),
                        Text("${snapshot.data!.docs[0]["email"]}",style: TextStyle(fontSize: smallFont,color: AppColors.textGrey),),

                      ],
                    )
                  ],
                );
              }
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
              text: "Adresse de livraison",
              icon: Icons.location_on_outlined,
              onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),
            ),

            ProfileMenus(
              text: "À propos de nous",
              icon: Icons.info_outline,
              onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs())),
            ),
            ProfileMenus(
              text: "Politique de confidentialité",
              icon: Icons.privacy_tip_outlined,
              onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy())),
            ),
            ProfileMenus(
              text: "Delete Accout",
              icon: Icons.privacy_tip_outlined,
              onClick: (){
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Es-tu sûr? '),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Es-tu sûr? Voulez-vous supprimer votre compte ? Si vous supprimez votre compte, vous ne pourrez plus utiliser ce compte. Il sera définitivement supprimé.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('YES'),
                          onPressed: () {
                            AuthController.deleteAccount(context);
                          },
                        ),
                        TextButton(
                          child: Text('NO'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SignOutButton(
        name:"Se déconnecter",
        onClick: (){
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false);
          });
        },
      ),
    ));
  }
}



