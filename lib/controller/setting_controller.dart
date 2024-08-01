import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar/utility/app_const.dart';

class SettingController{

  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  //setting
  static Future getSocialMedia()async{
    return await _firestore.collection(settingCollection).doc("social_media").get();
  }

  //setting
  static Future getSetting()async{
    return await _firestore.collection(settingCollection).doc("app_settings").get();
  }

}