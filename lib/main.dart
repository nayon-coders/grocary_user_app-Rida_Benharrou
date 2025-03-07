import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nectar/data/binding/auth_binding.dart';
import 'package:nectar/firebase_options.dart';
import 'package:nectar/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/app_pages.dart';

// Declare global controller
SharedPreferences ? sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: "kanitFont"
      ),
      locale: const Locale('fr', 'FR'), // Set French as default
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'), // Add French support
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.flashScreen,
      getPages: AppPages.routes,
      initialBinding: AuthBinding(),
    );
  }
}

