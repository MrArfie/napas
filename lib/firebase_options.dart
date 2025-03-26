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
    apiKey: 'AIzaSyD5p_yfoOZ3vKIs6JOJ9Jnf78B4YHkBWc4',
    appId: '1:678813210667:web:a38b9d947ee21c6eb4726e',
    messagingSenderId: '678813210667',
    projectId: 'noahs-arc-e7477',
    authDomain: 'noahs-arc-e7477.firebaseapp.com',
    storageBucket: 'noahs-arc-e7477.firebasestorage.app',
    measurementId: 'G-K5EX7ECV1Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB02pPOivj4Z-rCVmbBCLyyIKAMNj2QamE',
    appId: '1:678813210667:android:c0a7b2f51119d3f1b4726e',
    messagingSenderId: '678813210667',
    projectId: 'noahs-arc-e7477',
    storageBucket: 'noahs-arc-e7477.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5I1a26NDrk3AJ6KlB1_w6i4ueurhWKBg',
    appId: '1:678813210667:ios:ad97d37d2cd0b2a0b4726e',
    messagingSenderId: '678813210667',
    projectId: 'noahs-arc-e7477',
    storageBucket: 'noahs-arc-e7477.firebasestorage.app',
    iosBundleId: 'com.example.napas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5I1a26NDrk3AJ6KlB1_w6i4ueurhWKBg',
    appId: '1:678813210667:ios:ad97d37d2cd0b2a0b4726e',
    messagingSenderId: '678813210667',
    projectId: 'noahs-arc-e7477',
    storageBucket: 'noahs-arc-e7477.firebasestorage.app',
    iosBundleId: 'com.example.napas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5p_yfoOZ3vKIs6JOJ9Jnf78B4YHkBWc4',
    appId: '1:678813210667:web:ce767418f72d9a37b4726e',
    messagingSenderId: '678813210667',
    projectId: 'noahs-arc-e7477',
    authDomain: 'noahs-arc-e7477.firebaseapp.com',
    storageBucket: 'noahs-arc-e7477.firebasestorage.app',
    measurementId: 'G-KC7ZTNPWTH',
  );

}