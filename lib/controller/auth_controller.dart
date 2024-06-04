import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nectar/model/user_model.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/navigation_screen/navigation_screen.dart';


class AuthController{

  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;


  //user registration
  static void userRegistration({required BuildContext context, required UserModel userModel, required String pass}) {
    try {
      //create and account in firebase auth
      _auth.createUserWithEmailAndPassword(
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
  static Future userLogin({required BuildContext context, required String email, required String pass})async{
    try{
      //create and account in firebase auth
     await _auth.signInWithEmailAndPassword(email: email, password: pass).then((value){
        //store data
          appSnackBar(context: context, text: "Connexion réussie", bgColor: Colors.green);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> NavigationScreen()), (route) => false);
        });

    }catch(e){
      if(e.toString().contains("invalid-credential")){
        appSnackBar(context: context, text: "Invalid Credential", bgColor: Colors.red);
      }
      print("userLogin $e");
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


  //reset password
  static  Future forgotPassword({required String email, required BuildContext context}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      appSnackBar(context: context, text: "Vous avez envoyé un lien de réinitialisation dans votre e-mail. Veuillez vérifier l'e-mail.", bgColor: Colors.green);
    } on FirebaseAuthException catch (err) {
      appSnackBar(context: context, text: "${err.message.toString()}", bgColor: Colors.red);
      throw Exception(err.message.toString());

    } catch (err) {
      appSnackBar(context: context, text: "${err.toString()}", bgColor: Colors.red);

      throw Exception(err.toString());
    }
  }


  //account delete
  static deleteAccount(context)async{
    try{

      print("${ _auth.currentUser!.email}");
      //delete inofo
      _firestore.collection(userCollection).where("email", isEqualTo: _auth.currentUser!.email).get().then((value) {
        //delete firebase account


        if(value.docs[0].exists){
          _firestore.collection(userCollection).doc(value.docs[0].id).delete();
          _auth.currentUser!.delete();
        }
        appSnackBar(context: context, text: "Votre compte a été supprimé. Vous pouvez créer un nouveau compte pour continuer.", bgColor: Colors.green);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInScreen()), (route) => false);

      });

    }catch(e){
      print("delete account error----- $e");
      appSnackBar(context: context, text: "Something went wrong", bgColor: Colors.red);
    }
  }
  

}