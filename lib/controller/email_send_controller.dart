import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nectar/app_config.dart';
import 'package:nectar/controller/auth_controller.dart';
import 'package:nectar/model/user_model.dart';


class EmailSendController{


  //send to the admin
  static sendAdminEmail({required Map orders})async{

    //get the profile
    var customerInfo = await AuthControllerOld.getMyInfo();
    UserModel customer = UserModel.fromJson(customerInfo.docs[0].data());



    var response = await http.post(Uri.parse(AppConfig.EMAIL_SEND_API),
       body: jsonEncode({
          "email": "nayon.coders@gmail.com",
           "subject": "Merci de vérifier cette commande et de procéder au traitement.",
           "text": '''
            Date de commande : ${orders["create_at"]}
            Livraison : ${orders["address"]["street_number"]}, ${orders["address"]["state"]}, ${orders["address"]["city"]}, ${orders["address"]["country"]}, ${orders["address"]["zip"]}
            Nom: ${customer.company}
            Contact: ${customer.name}
            Mobile: ${orders["address"]["phone"]}
            Email du client : ${customer.email}
            Montant total ttc: ${orders["total"]}

            Numéro de commande : ${orders["id"]}

            Merci de vérifier cette commande et de procéder au traitement.

            L'équipe
            Commandes Pros"
            '''
        }),

      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    print("response.statusCode ----- ${response.statusCode}");
    print("response.statusCode body ----- ${response.body}");
    if(response.statusCode == 200){
      print(".......");
      print("............... YES...... Email is send to the admin");
    }

  }


  //send to the admin
  static sendCustomerEmail({required Map orders})async{

    //get the profile
    var customerInfo = await AuthControllerOld.getMyInfo();
    UserModel customer = UserModel.fromJson(customerInfo.docs[0].data());


    var response = await http.post(Uri.parse(AppConfig.EMAIL_SEND_API),
        body: {
          "email": customer.email,
          "subject": "Merci de vérifier cette commande et de procéder au traitement.",
          "text": '''
            Date de commande : ${orders["create_at"]}
            Livraison : "${orders["address"]["street_number"]}, ${orders["address"]["state"]}, ${orders["address"]["city"]}, ${orders["address"]["country"]}, ${orders["address"]["zip"]}"
            Nom: ${customer.company}
            Contact: ${customer.name}
            Mobile: ${orders["address"]["phone"]}
            Email du client : ${customer.email}
            Montant total ttc: ${orders["total"]}
            
            Numéro de commande : ${orders["id"]}
            
            Merci de vérifier cette commande et de procéder au traitement.
            
            L'équipe 
            Commandes Pros"	
            '''
        }
    );


    if(response.statusCode == 200){
      print(".......");
      print("............... YES...... Email is send to the admin");
    }

  }


}