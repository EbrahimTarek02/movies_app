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
    apiKey: 'AIzaSyAyY0yq3L-FYzsJxrR-qj6lraz3guEgLn4',
    appId: '1:786333020628:web:b62cab41237a88a98a6641',
    messagingSenderId: '786333020628',
    projectId: 'movies-app-dbff5',
    authDomain: 'movies-app-dbff5.firebaseapp.com',
    storageBucket: 'movies-app-dbff5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUESsGYdrjQGWBldlWE52lY2JbMxv_wzo',
    appId: '1:786333020628:android:7a759b488ce3b5f28a6641',
    messagingSenderId: '786333020628',
    projectId: 'movies-app-dbff5',
    storageBucket: 'movies-app-dbff5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHg2DcbEyd_kY33uHcLNI3DF7XOVjVwKo',
    appId: '1:786333020628:ios:dd8d82de6aff83418a6641',
    messagingSenderId: '786333020628',
    projectId: 'movies-app-dbff5',
    storageBucket: 'movies-app-dbff5.appspot.com',
    iosBundleId: 'com.example.moviesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHg2DcbEyd_kY33uHcLNI3DF7XOVjVwKo',
    appId: '1:786333020628:ios:bfd457bcf1147d238a6641',
    messagingSenderId: '786333020628',
    projectId: 'movies-app-dbff5',
    storageBucket: 'movies-app-dbff5.appspot.com',
    iosBundleId: 'com.example.moviesApp.RunnerTests',
  );
}
