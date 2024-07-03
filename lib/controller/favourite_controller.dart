import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/product_model.dart';

import '../utility/app_const.dart';


class FavouriteController{

  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  //add favourite
  static addFavourite(String productId, BuildContext context){
    if(_firebaseAuth.currentUser !=null) {
      try {
        _firestore.collection(favCollection).add({
          "id": productId,
          "user_email": _firebaseAuth.currentUser!.email.toString(),
        });
         appSnackBar(context: context,
            text: "Produit ajouter à la liste des favoris",
            bgColor: Colors.green);
      } catch (e) {
        print("addFavourite --- ${e}");
      }
    }else{
      appSnackBar(context: context,
          text: "Tu dois d'abord te connecter",
          bgColor: Colors.red);
    }
  }

  //get favourite list
  static Stream<QuerySnapshot<Map<String, dynamic>>> getFavouriteLise(){
    return _firestore.collection(favCollection).where("user_email", isEqualTo: _firebaseAuth.currentUser!.email).snapshots();
  }

  //remove from facourite list
  static removeFavouriteList(context, docId){
    _firestore.collection(favCollection).doc(docId).delete();
    appSnackBar(context: context, text: "Supprimer de la liste des favoris.", bgColor: Colors.green);
  }

  //check if thie product is already in fav list
  static bool productIsInFavList(productId){
    try{
      bool available = false;

      _firestore.collection(favCollection).where("user_email", isEqualTo: _firebaseAuth.currentUser!.email).where("id", isEqualTo: productId).get().then((value) {
        for(var i in value.docs){
          if(i.exists){
            available = true;
          }
        }
      });
      return available;
    }catch(e){
      print("productIsInFavList --- $e");
      return false;
    }
  }


  //get fav
  static Future<List<ProductModel>> getFavProduct()async{
    List<ProductModel> products = [];
    try{
      await _firestore.collection(favCollection).where("user_email", isEqualTo: _firebaseAuth.currentUser!.email).get().then((favValue)async{
        for(var i in favValue.docs){
          await FirebaseFirestore.instance.collection(productCollection).where("id", isEqualTo: i.data()["id"]).get().then((value){
            for(var prd in value.docs){
              products.add(ProductModel.fromJson(prd.data()));
            }
          });
        }
      });
      return products;
    }catch(e){
      print("getfavprod -- $e");
      return products;
    }
  }

}