import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/model/orders_model.dart';
import 'package:nectar/model/product_model.dart';
import 'package:nectar/utility/app_const.dart';


class ProductController{
  
  //firebase instance 
  static final _firestore = FirebaseFirestore.instance; 
  static final _firebaseAuth = FirebaseAuth.instance;

  //get offer/discrount products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getOfferProduct (){
    return _firestore.collection(productCollection).where("discount_price", isNotEqualTo: "").snapshots();
  }

  //get offer/discrount products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDeals (){
    return _firestore.collection(productCollection).where("product_type", isEqualTo: "KG (Kilogram)").snapshots();
  }
  //get offer/discrount products
  static Future<List<ProductModel>> getRecomandationProduct ()async{
    List<ProductModel> product = [];
    final snapshot = await _firestore.collection(productCollection).get();
    final documents = snapshot.docs;

    // Shuffle the documents randomly
    documents.shuffle();

    var random = Random().nextInt(99);
    // Select the desired number of random documents
    for(var i in documents.sublist(0, 20)){
      product.add(ProductModel.fromJson(i.data()));
    }

    return product;


  }




  //get offer/discrount products
  static Stream<QuerySnapshot<Map<String, dynamic>>> getBestSellingProducts (){
    return _firestore.collection(productCollection).where("best_selling", isEqualTo: "1").snapshots();
  }

  //get  recent product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNewProduct (){
    return _firestore.collection(productCollection).snapshots();
  }

  //get  recent product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getNewAll (){
    return _firestore.collection(productCollection).limit(20).snapshots();
  }

  //get  category wish product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCategroyWishProduct (categoryName){
    return _firestore.collection(productCollection).where("category's.category_name", isEqualTo: categoryName).snapshots();
  }


  //get  category wish product
  static Stream<QuerySnapshot<Map<String, dynamic>>> getSubCategroyWishProduct (categoryName){
    return _firestore.collection(productCollection).where("sub_category", arrayContains: categoryName).snapshots();
  }



}