import 'package:flutter/material.dart';
import 'package:nectar/view/auth/login_screen.dart';
import 'package:nectar/view/flash/flash.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:FlashScreen(),
    );
  }
}

