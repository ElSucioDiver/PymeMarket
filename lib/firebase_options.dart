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
    apiKey: 'AIzaSyBYpOyES0aVL9qZXT9Cg1BV3bbdlVdmm20',
    appId: '1:885705382188:web:26b76eec06cfe7bf8c3489',
    messagingSenderId: '885705382188',
    projectId: 'talleriot-6ef5c',
    authDomain: 'talleriot-6ef5c.firebaseapp.com',
    storageBucket: 'talleriot-6ef5c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSBZa-yeNl-7UZxOaZF-sUtP8belVbrQE',
    appId: '1:325024453062:android:861115791eb011717fe2c7',
    messagingSenderId: '325024453062',
    projectId: 'proyecto-iot-112ea',
    storageBucket: 'proyecto-iot-112ea.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm2zP-mwrJzuUIYE0VTWb0eEgW0fwOjdY',
    appId: '1:885705382188:ios:1e6fa16ea7aafc908c3489',
    messagingSenderId: '885705382188',
    projectId: 'talleriot-6ef5c',
    storageBucket: 'talleriot-6ef5c.firebasestorage.app',
    iosBundleId: 'com.example.miProyecto',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCm2zP-mwrJzuUIYE0VTWb0eEgW0fwOjdY',
    appId: '1:885705382188:ios:1e6fa16ea7aafc908c3489',
    messagingSenderId: '885705382188',
    projectId: 'talleriot-6ef5c',
    storageBucket: 'talleriot-6ef5c.firebasestorage.app',
    iosBundleId: 'com.example.miProyecto',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBYpOyES0aVL9qZXT9Cg1BV3bbdlVdmm20',
    appId: '1:885705382188:web:9fdd72658baf4f568c3489',
    messagingSenderId: '885705382188',
    projectId: 'talleriot-6ef5c',
    authDomain: 'talleriot-6ef5c.firebaseapp.com',
    storageBucket: 'talleriot-6ef5c.firebasestorage.app',
  );
}