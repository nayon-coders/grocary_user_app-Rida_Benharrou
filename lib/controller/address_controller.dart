import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/address_model.dart';
import 'package:nectar/utility/app_const.dart';

class AddressController{

  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;


  //add address
  static addAddress(BuildContext context, AddressModel addressModel){
    try{
      _firestore.collection(addressCollection).add(addressModel.toJson());
      appSnackBar(context: context, text: "L'adresse a été ajoutée", bgColor: Colors.green);
    }catch(e){
      print("addAddress ---- ${e}"); 
    }
  }
  
  

  //get address
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAddress(){
    return _firestore.collection(addressCollection).where("email", isEqualTo: _auth.currentUser!.email).snapshots();
  }


}