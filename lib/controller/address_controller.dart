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
      Navigator.pop(context);
    }catch(e){
      print("addAddress ---- ${e}");
    }
  }


  //add address
  static editAddress(BuildContext context, AddressModel addressModel, String docId){
    try{
      _firestore.collection(addressCollection).doc(docId).update(addressModel.toJson());
      appSnackBar(context: context, text: "L'adresse a été modifiée.", bgColor: Colors.green);
      Navigator.pop(context);
    }catch(e){
      print("addAddress ---- ${e}");
    }
  }



  //get address
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAddress(){
    return _firestore.collection(addressCollection).where("email", isEqualTo: _auth.currentUser!.email).snapshots();
  }
  static Future<List<AddressModel>> getInitAddress()async{
    List<AddressModel> initAddress = [];
    var data = await _firestore.collection(addressCollection).where("email", isEqualTo: _auth.currentUser!.email).get();
    for(var i in data.docs){
      initAddress.add(AddressModel.fromJson(i.data()));
    }

    return initAddress;
  }



  //get address
  static deleteAddress(context, id)async{
    try{
      _firestore.collection(addressCollection).doc(id).delete();
      appSnackBar(context: context, text: "L'adresse a été supprimée.", bgColor: Colors.green);
      Navigator.pop(context);
    }catch (e){
      appSnackBar(context: context, text: "Something went wrong", bgColor: Colors.red);

    }
  }

  //get post code
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllPostCode(){
    return _firestore.collection(postCodeCollection).snapshots();
  }

}