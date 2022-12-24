// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCtGiYSR_a2C5coC6UOm4CkXZbgVEmJif0',
    appId: '1:574111371403:web:d2abf3d1617241cfa6848e',
    messagingSenderId: '574111371403',
    projectId: 'grocery-9428d',
    authDomain: 'grocery-9428d.firebaseapp.com',
    storageBucket: 'grocery-9428d.appspot.com',
    measurementId: 'G-40Y8C82G5M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2vCwC_jQ0vG1zq166X43tJl2tZwgyVvg',
    appId: '1:574111371403:android:54d87bd4ee9791f2a6848e',
    messagingSenderId: '574111371403',
    projectId: 'grocery-9428d',
    storageBucket: 'grocery-9428d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFv_Afcsk5SwBlbUkwwdN-zV5b50lYBBE',
    appId: '1:574111371403:ios:adba4f79d9d6202da6848e',
    messagingSenderId: '574111371403',
    projectId: 'grocery-9428d',
    storageBucket: 'grocery-9428d.appspot.com',
    iosClientId: '574111371403-2uhb28qlvdci2ciugge4l9j97tr6hl0o.apps.googleusercontent.com',
    iosBundleId: 'com.example.delivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFv_Afcsk5SwBlbUkwwdN-zV5b50lYBBE',
    appId: '1:574111371403:ios:adba4f79d9d6202da6848e',
    messagingSenderId: '574111371403',
    projectId: 'grocery-9428d',
    storageBucket: 'grocery-9428d.appspot.com',
    iosClientId: '574111371403-2uhb28qlvdci2ciugge4l9j97tr6hl0o.apps.googleusercontent.com',
    iosBundleId: 'com.example.delivery',
  );
}
