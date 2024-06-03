

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class CartController{

  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  //add to cart
  static addToCar(context, id, qty){
    try{
      _firestore.collection(cartCollection).add({
        "email" : _auth.currentUser!.email,
        "id" :  id,
        "qty" : qty
      });
      appSnackBar(context: context, text: "Produit ajouté à votre panier", bgColor: Colors.green);
    }catch(e){
      print("addToCar ------ ${e}");
    }
  }


  //get cart
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCart(){
    return _firestore.collection(cartCollection).where("email", isEqualTo: _auth.currentUser!.email).snapshots();
  }

  //remove from cart
  static removeFromCart(context, id)async{
    try{
      _firestore.collection(cartCollection).doc(id).delete();
      appSnackBar(context: context, text: "Le produit a été supprimé du panier", bgColor: Colors.green);
    }catch(e){
      print("removeFromCart --- ${e}");
    }
  }


  //get cart prododucts
  static Future< List<ProductModel>> getCartProduct()async{
    List<ProductModel> products = [];
    try{
      await _firestore.collection(cartCollection).where("email", isEqualTo: _auth.currentUser!.email).get().then((favValue)async{
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


   //count cart leng
  static Future<int>  getCartCount()async{
    var count = 0;
    try{
     _firestore.collection(cartCollection).where("email", isEqualTo: _auth.currentUser!.email).get().then((value) {

     });

     return count;

    }catch(e){
      print("get cart count $e");
      return count;
    }
  }

}