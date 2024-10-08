import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/model/user_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/utility/assets.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/auth/widget/app_field.dart';
import 'package:nectar/widget/app_button.dart';
import 'package:nectar/widget/app_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/app_color.dart';
import '../../utility/fontsize.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _companyController = TextEditingController();
  final _brandController = TextEditingController();
  final _addressController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stratController = TextEditingController();


  final _contactFacturation = TextEditingController();
  final _contactComptabilit = TextEditingController();
  final _contactEmail = TextEditingController();
  final _contactPhone = TextEditingController();


  List accountType = [restaurantAccount, sellerAccount, wholeSellerAccount];
  List accountTypeName = ["Restauration", "Revendeur", "Grossiste"];
  List selectedType = [];
  bool _isLoading = false;
  bool _obscureText = true;
  bool _checkTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.bgWhite,
      body: SafeArea(
        child: SingleChildScrollView(
         // padding: EdgeInsets.only(top: 60),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //image: DecorationImage(image:AssetImage(Assets.loginbg),fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: Image.asset(AppAssets.logo, width: 300,),
                    ),
                    )
                  ],
                ),
               Padding(
                 padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 50),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
        
                     Text("S'inscrire",
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         fontSize: bigFont,
                         color: AppColors.textBlack,
                       ),
                     ),
                     SizedBox(height: 5,),
                     Text("Remplissez tous les champs pour valider votre inscription.",
                       style: TextStyle(
                         fontWeight: FontWeight.w400,
                         fontSize: smallFont,
                         color: AppColors.textGrey,
                       ),
                     ),
        
                     SizedBox(height: 30,),
        
                     Text("Choisir votre profil *",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      )
                     ),
                      SizedBox(height: 10,),
        
                      SizedBox(height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap:true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: accountType.length,
                          itemBuilder: (_, index){
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedType.clear();
                                  selectedType.add(accountType[index]);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 7),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selectedType.contains(accountType[index])  ? AppColors.bgGreen : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1, color: selectedType.contains(accountType[index]) ? Colors.white :   AppColors.bgGreen ,)
                                  ),
                                  child: Text(
                                    "${accountTypeName[index]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                         fontSize: 12,
                                         color: selectedType.contains(accountType[index]) ? Colors.white :   AppColors.bgGreen
                                  ),
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                     SizedBox(height: 20,),
        
        
                     Text("E-mail *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _emailController,
                       hintText: "Indiquez votre email",
                     ),
        
                     SizedBox(height: 20,),
        
                     Text("Mot de passe *",
                       style: TextStyle(fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                         controller: _passwordController,
                         hintText: "hoisissez un mot de passe facile à retenir",
                         obscureText: _obscureText,
                         suffixIcon: IconButton(
                           onPressed: (){
                             setState(() {
                               _obscureText = !_obscureText;
                             });
        
                           },
                           icon: Icon(_obscureText ? Icons.remove_red_eye : Icons.visibility_off,color: AppColors.textGrey,),
                         )),
        
                     // SizedBox(height: 20,),
                     // Text("Nom d'utilisateur *",
                     //   style: TextStyle(
                     //       fontSize: normalFont,
                     //       fontWeight: FontWeight.w500,
                     //       color: AppColors.textGrey),),
                     // AppField(
                     //     controller: _usernameController,
                     //     hintText: "Nom d'utilisateur",
                     // ),
                     //
                     SizedBox(height: 20,),
                     Text("Société *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _companyController,
                       hintText: "Nom de la société tel que sur le KBIS",
                     ),
                     SizedBox(height: 20,),
        
                     Text("Enseigne *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _brandController,
                       hintText: "Nom commercial de votre société",
                     ),
                     SizedBox(height: 20,),
        
        
                     Text("Adresse de Facturation *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _addressController,
                       hintText: "Adresse",
                     ),
                     SizedBox(height: 20,),
                     Text("Ville *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _cityController,
                       hintText: "Ville",
                     ),
                     SizedBox(height: 20,),
        
        
        
                     Text("Siret *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _stratController,
                       hintText: "N° SIRET tel que sur le KBIS",
                     ),
                     SizedBox(height: 20,),
        
                     Text("Code postal *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _postCodeController,
                       hintText: "Code postal",
                     ),
                     SizedBox(height: 20,),
                     Text("Contact Facturation / Compabilité",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: Colors.black),),
                     SizedBox(height: 20,),
                     Text("Contact facturation *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _contactFacturation,
                       hintText: "Nom, Prénom",
                     ),
        
                     SizedBox(height: 20,),
                     Text("Email *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _contactEmail,
                       hintText: "Email",
                     ),
                     SizedBox(height: 20,),
        
                     Text("Mobile *",
                       style: TextStyle(
                           fontSize: normalFont,
                           fontWeight: FontWeight.w500,
                           color: AppColors.textGrey),),
                     AppField(
                       controller: _contactPhone,
                       hintText: "Mobile / Ligne direct",
                     ),
                     SizedBox(height: 20,),
        
        
        
                     SizedBox(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Checkbox(
                               value: _checkTerms, onChanged: (v){
                                 setState(() {
                                   _checkTerms = !_checkTerms;
                                 });
                           }
                           ),
                           SizedBox(width: 3,),
                           SizedBox(
                             width: 230,
                             child: RichText(text: TextSpan(
                                 text: "En continuant vous confirmez que vous avez lu et accepté les Conditions Générales de Ventes ainsi que la Politique de Confidentialité.  ",
                                 style: TextStyle(fontSize: smallFont,fontWeight: FontWeight.w500,color:AppColors.textGrey),
                                 children: [
                                   TextSpan(
                                       recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(Uri.parse("https://commandespros.com/conditions-generales-de-vente/")),
                                       text: "(Cliquez pour consulter)",
                                       style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.bgGreen)
                                   ),
                                   // TextSpan(
                                   //     text: " de Ventes ainsi que",
                                   //     style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.textGrey)
                                   // ),
                                   // TextSpan(
                                   //     recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(Uri.parse("https://commandespros.com/politique-de-confidentialite/")),
                                   //     text: " laPolitique de Confidentialité",
                                   //     style: TextStyle(fontWeight: FontWeight.w500,fontSize: smallFont,color:AppColors.bgGreen)
                                   // ),
                                 ]
                             )),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 40,),
                     AppButton(
                      isLoading: _isLoading,
                       bgColor: AppColors.bgGreen,
                       name: "S'inscrire", onClick: ()async{
                        setState(() {
                          _isLoading = true;
                        });
                         if(selectedType.isEmpty){
                           appSnackBar(context: context, text: "Veuillez choisir votre type de compte", bgColor: Colors.red);
                           return;
                         }
                         if(_key.currentState!.validate()){
                           int id = Random().nextInt(9999999);
                           var userModel = UserModel(
                             id: id.toString(),
                             email: _emailController.text,
                             name: _usernameController.text,
                             company: _cityController.text,
                             brand: _brandController.text,
                             address: _addressController.text,
                             city: _cityController.text,
                             postCode: _postCodeController.text,
                             siret: _stratController.text,
                             status: "Pending",
                             contactFacturation: _contactFacturation.text,
                             accountEmail: _contactEmail.text,
                             accountPhone: _contactPhone.text,
                             accountType: selectedType[0],
                             createAt: DateFormat("dd/MM/yyyy").format(DateTime.now())
                           );
                           AuthController.userRegistration(context: context, userModel: userModel, pass: _passwordController.text);
                         }
                        setState(() {
                          _isLoading = false;
                        });
                       //Navigator.push(context, MaterialPageRoute(builder: (_)=>LogInScreen()));
                     },
                     ),
                     SizedBox(height: 20,),
                     Center(
                       child: InkWell(
                         onTap: ()=>
                             Navigator.push(context, MaterialPageRoute(builder: (_)=>LogInScreen())),
                         child: RichText(text: TextSpan(
                             text: "Vous avez déjà un compte? ",
                             style: TextStyle(
                                 fontSize: normalFont,
                                 fontWeight: FontWeight.w500,
                                 color: Colors.black),
                             children: [
                               TextSpan(
                                   text: "Se connecter",
                                   style: TextStyle(
                                     fontWeight: FontWeight.w500,
                                     fontSize: normalFont,
                                     color:AppColors.bgGreen,
                                   )
                               )
                             ]
                         )),
                       ),
                     ),
        
                   ],
                 ),
               )
        
        
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


}
