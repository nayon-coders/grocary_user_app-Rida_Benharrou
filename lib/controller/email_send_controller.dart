import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


class EmailSendController{


  //send to the admin
  static sendEmailToAdmin()async{
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['nayon.coders@gmail.com'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Email sent';
    } catch (error) {
      platformResponse = error.toString();
    }

    print(platformResponse);

  }


}