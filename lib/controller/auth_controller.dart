import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/user_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';


class AuthController{

  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;


  //user registration
  static  userRegistration({required BuildContext context, required UserModel userModel, required String pass}) async{
    try {
      //create and account in firebase auth
     await _auth.createUserWithEmailAndPassword(
          email: userModel.email!, password: pass).then((value) {
        //store data 
        _firestore.collection(usersCollection).add(userModel.toJson()).then((
            value) {
          appSnackBar(context: context,
              text: "Le compte a été créé",
              bgColor: Colors.green);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => NavigationScreen()), (
                  route) => false);
        });
      });
    } catch (e) {
      print("userRegistration $e");
    }
  }

  //user login
  static  userLogin({required BuildContext context, required String email, required String pass})async{
    print("value -==== ");


    try{
      //create and account in firebase auth
      await _auth.signInWithEmailAndPassword(email: email, password: pass).then((value){
        //store data
        print("value -==== ${value}");
        if(value != null){
          appSnackBar(context: context, text: "Connexion réussie", bgColor: Colors.green);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> NavigationScreen()), (route) => false);
        }else{
          appSnackBar(context: context, text: "Invalid credential.", bgColor: Colors.red);

        }

        });



    } catch(e){
      print("userLogin ---------------------- $e");
        appSnackBar(context: context, text: "Invalid credential.", bgColor: Colors.red);
     // if(e.toString().contains(other))
    }
  }


  //get the account Role
  static Future<String> accountRole()async{
    String accountType =  "";
    try{
      if (_auth.currentUser != null) {
        QuerySnapshot value = await _firestore.collection(userCollection).get();
        for (var i in value.docs) {
          var data = UserModel.fromJson(i.data() as Map<String, dynamic>);
          if (data.email == _auth.currentUser!.email) {
            accountType = data.accountType!;
            break; // Assuming each user email is unique, exit loop once found
          }
        }
      }
      print("accountRole -- $accountType");
      return accountType;

    }catch(e){
      print("accountRole -- $e");
      return accountType;
    }
  }
  
  //my account info 
  static Future<QuerySnapshot<Map<String, dynamic>>> getMyInfo()async{
    return _firestore.collection(userCollection).where("email", isEqualTo:  _auth.currentUser!.email).get();
  }




  //delete account
  static deleteAccout(BuildContext context)async{
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await user?.delete();
      appSnackBar(context: context, text: "Votre compte a été supprimé", bgColor: Colors.green);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false);
    } catch (e) {
      if(e.toString().contains("requires-recent-login")){
    appSnackBar(context: context, text: "Cette opération est sensible et nécessite une authentification récente. Reconnectez-vous avant de réessayer cette demande.", bgColor: Colors.red);
    Navigator.pop(context);
    }
      print('Failed to delete user account: $e');

      // Handle error appropriately, such as showing an error message to the user
    }
  }


  //logout
  static logOut(context)async{
    try{
      await FirebaseAuth.instance.signOut();
      appSnackBar(context: context, text: "Vous devez vous connecter ou créer un nouveau compte pour continuer.", bgColor: Colors.green);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false);
    }catch(e){
      appSnackBar(context: context, text: "Something went wrong", bgColor: Colors.red);
    }
  }


  //get privacy
  static getPrivacyPolicy()async{
    return await _firestore.collection(settingCollection).doc("app_settings").get();
  }

  

}