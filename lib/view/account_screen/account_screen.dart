

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/controller/setting_controller.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/utility/fontsize.dart';
import 'package:nectar/view/account_screen/about_us.dart';
import 'package:nectar/view/account_screen/contact_widgets/terms_conditions.dart';
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

  //get social media
  var whatsapp, whatsAppMessages, terms, policy, legal;
  getSocialMedia()async{
    var res = await SettingController.getSocialMedia();
    print("res --- ${res}");
    setState(() {
      whatsapp = res.data()["whatssapp"];
      whatsAppMessages = res.data()["whatsapp_messages"];
    });
  }

  getSettings()async{
    var res = await SettingController.getSetting();
    print("res --- ${res}");
    setState(() {
      terms = res.data()["terms"];
      policy = res.data()["privacy"];
      legal = res.data()["legal"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSocialMedia();
    getSettings();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 200,
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.pink.shade100
              ),
              child: FutureBuilder(
                  future: AuthController.getMyInfo(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ravis de vous revoir,",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.pink,
                            fontSize: 35
                          ),
                        ),
                        Text("${snapshot.data!.docs[0].data()["company"]}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.pink),),
                      ],
                    );
                  }
              ),
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
                      Text("Mon compte",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Mes commandes",
                        icon: Icons.shopping_bag_outlined,
                        onClick: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders()));
                        },
                      ),

                      ProfileMenus(
                        text: "Adresses de livraison",
                        icon: Icons.location_on_outlined,
                        onClick: ()=>Navigator.push(context,MaterialPageRoute(builder: (_)=>AddressList())),
                      ),
                      ProfileMenus(
                        text: "Favoris",
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
                      Text("Contact & Information",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Contactez-nous",
                        icon: Icons.help_outline_outlined,
                        onClick: (){
                          print("https://wa.me/$whatsapp?text=$whatsAppMessages");
                          _launchUrl(Uri.parse("https://wa.me/$whatsapp?text=$whatsAppMessages"));
                        }
                      ),
                      ProfileMenus(
                        text: "Conditions générales de vente",
                        icon: Icons.info_outline,
                       onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions(data: terms ?? "Terms", title: "Conditions générales de vente",))),
                       // onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/conditions-generales-de-vente/")),
                      ),
                      ProfileMenus(
                        text: "Politique de confidentialité",
                        icon: Icons.info_outline,
                        onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions(data: policy ?? "Privacy", title: "Politique de confidentialité",))),

                        // onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/politique-de-confidentialite/")),
                      ), ProfileMenus(
                        text: "Mentions légales",
                        icon: Icons.info_outline,
                        onClick: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions(data: legal ??"Legal", title: "Mentions légales",))),

                        //onClick: ()=>_launchUrl(Uri.parse("https://commandespros.com/politique-de-confidentialite/")),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Paramètres",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,

                        ),
                      ),
                      SizedBox(height: 10,),
                      ProfileMenus(
                        text: "Supprimer mon compte",
                        icon: Icons.delete,
                        onClick: (){
                          AppDialog(
                              context,
                              "Suppression de votre compte",
                              "Souhaitez-vous réellement supprimer votre compte?",
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
              "Déconnexion",
              "Souhaitez-vous vraiment vous déconnecter?",
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



