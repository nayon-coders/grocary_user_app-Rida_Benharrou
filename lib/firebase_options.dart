// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBl_Ecmu6YZwz0A5GAZAVv1bh39MBlMq4',
    appId: '1:656750425910:web:785644ea5331e0fb356597',
    messagingSenderId: '656750425910',
    projectId: 'grocaryecommerce',
    authDomain: 'grocaryecommerce.firebaseapp.com',
    storageBucket: 'grocaryecommerce.appspot.com',
    measurementId: 'G-0ZJVQTT15E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCURgKrZeA7hKosqEIKwE8uX_IgzrmCnSk',
    appId: '1:656750425910:android:baf230efc2ecdb6d356597',
    messagingSenderId: '656750425910',
    projectId: 'grocaryecommerce',
    storageBucket: 'grocaryecommerce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSYzUTpZoxgn8fWcE180XoKb0YxzTjBzo',
    appId: '1:656750425910:ios:dab17e618cb7be62356597',
    messagingSenderId: '656750425910',
    projectId: 'grocaryecommerce',
    storageBucket: 'grocaryecommerce.appspot.com',
    iosBundleId: 'com.example.nectar',
  );
}
