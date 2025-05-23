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
    apiKey: 'AIzaSyA_hyR5AkKpnqpvr9U0N7nosnCiNARrVQo',
    appId: '1:988924981554:web:284c0c9d3366fb3acca72b',
    messagingSenderId: '988924981554',
    projectId: 'suktha-notifications',
    authDomain: 'suktha-notifications.firebaseapp.com',
    storageBucket: 'suktha-notifications.firebasestorage.app',
    measurementId: 'G-WET7G01VQC',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpdThVjpfHa4P3T0enaodN_mFofP1EPlQ',
    appId: '1:988924981554:ios:6c199dd865e3b192cca72b',
    messagingSenderId: '988924981554',
    projectId: 'suktha-notifications',
    storageBucket: 'suktha-notifications.firebasestorage.app',
    iosBundleId: 'com.example.sukthaCrm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpdThVjpfHa4P3T0enaodN_mFofP1EPlQ',
    appId: '1:988924981554:ios:6c199dd865e3b192cca72b',
    messagingSenderId: '988924981554',
    projectId: 'suktha-notifications',
    storageBucket: 'suktha-notifications.firebasestorage.app',
    iosBundleId: 'com.example.sukthaCrm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA_hyR5AkKpnqpvr9U0N7nosnCiNARrVQo',
    appId: '1:988924981554:web:69e028475df984c0cca72b',
    messagingSenderId: '988924981554',
    projectId: 'suktha-notifications',
    authDomain: 'suktha-notifications.firebaseapp.com',
    storageBucket: 'suktha-notifications.firebasestorage.app',
    measurementId: 'G-9X0TVMNPLV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHVZYyVrreFob0tAkfk5KVQFSYEZlz3rI',
    appId: '1:988924981554:android:93f18283b4e9ea6bcca72b',
    messagingSenderId: '988924981554',
    projectId: 'suktha-notifications',
    storageBucket: 'suktha-notifications.firebasestorage.app',
  );

}