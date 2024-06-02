import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/app_const.dart';


class ProductController{
  
  //firebase instance 
  static final _firestore = FirebaseFirestore.instance; 
  
  //get offer/discrount products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getOfferProduct (){
    return _firestore.collection(productCollection).where("discount_price", isNotEqualTo: "0").snapshots();
  }

  //get offer/discrount products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getBestSellingProducts (){
    return _firestore.collection(productCollection).where("best_selling", isEqualTo: "1").snapshots();
  }

  //get  recent product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNewProduct (){
    return _firestore.collection(productCollection).snapshots();
  }
}