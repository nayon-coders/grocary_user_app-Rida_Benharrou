import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/controller/email_send_controller.dart';
import 'package:nectar/utility/app_const.dart';
import 'package:nectar/view/order_accepted/order_accepted.dart';

class OrderController{

  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;


  //place order
  static Future placeOrder(BuildContext context, Map<String, dynamic> orders, List<String> docId)async{
    try{
     await _firestore.collection(ordersCollection).add(orders).then((value)async{
        //delete all cart item
        for(var i =0; i<docId.length; i++){
          _firestore.collection(cartCollection).doc(docId[i]).delete();
        }

        // //send email to the user and admin
        // await EmailSendController.sendAdminEmail(
        //     orders : orders
        // );
        //
        // await EmailSendController.sendCustomerEmail(
        //     orders : orders
        // );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OrderAccepted()), (route) => false);

      });


    }catch(e){
      print("placeOrder ---- $e");
    }

  }

  //get order list
  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrders(){
    return _firestore.collection(ordersCollection).where("create_by", isEqualTo: _auth.currentUser!.email).snapshots();
  }


}