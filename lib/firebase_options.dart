// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_messaging/firebase_messaging.dart';
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCr4ukpivM3CHK7eIhHp1feV8j0u_DrAqA',
    appId: '1:310546095918:web:85b7e8ab8e8f520f7b64bf',
    messagingSenderId: '310546095918',
    projectId: 't43443-4dda2',
    authDomain: 't43443-4dda2.firebaseapp.com',
    storageBucket: 't43443-4dda2.firebasestorage.app',
    measurementId: 'G-KSFKYGM2G2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1ONMcnc3eloKqx1gMMhPiwms-eYs6c2U',
    appId: '1:310546095918:android:c7af443d8ed53f287b64bf',
    messagingSenderId: '310546095918',
    projectId: 't43443-4dda2',
    storageBucket: 't43443-4dda2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMFynLB9woa6UMhBAug3i-DGHw6g5PAIs',
    appId: '1:310546095918:ios:563a1dd7ff1b92f77b64bf',
    messagingSenderId: '310546095918',
    projectId: 't43443-4dda2',
    storageBucket: 't43443-4dda2.firebasestorage.app',
    iosBundleId: 'com.example.t43443',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMFynLB9woa6UMhBAug3i-DGHw6g5PAIs',
    appId: '1:310546095918:ios:563a1dd7ff1b92f77b64bf',
    messagingSenderId: '310546095918',
    projectId: 't43443-4dda2',
    storageBucket: 't43443-4dda2.firebasestorage.app',
    iosBundleId: 'com.example.t43443',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCr4ukpivM3CHK7eIhHp1feV8j0u_DrAqA',
    appId: '1:310546095918:web:0e4c6998d1cbf3f07b64bf',
    messagingSenderId: '310546095918',
    projectId: 't43443-4dda2',
    authDomain: 't43443-4dda2.firebaseapp.com',
    storageBucket: 't43443-4dda2.firebasestorage.app',
    measurementId: 'G-BNKY0R0GQM',
  );

}

Future<void> setupFirebase() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}