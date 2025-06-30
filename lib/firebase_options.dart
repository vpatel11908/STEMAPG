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
    if (kIsWeb)  {
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
    apiKey: 'AIzaSyBb4ryXag-Di6vBOFHUL2b84383RydSdsk',
    appId: '1:991651846135:web:7fb9375a4b3a6ddc4cc0f2',
    messagingSenderId: '991651846135',
    projectId: 'varinyprojectplanner',
    authDomain: 'varinyprojectplanner.firebaseapp.com',
    databaseURL: 'https://varinyprojectplanner-default-rtdb.firebaseio.com',
    storageBucket: 'varinyprojectplanner.firebasestorage.app',
    measurementId: 'G-MMLWPHYC8F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2xh-f84WXQaDDgLMgwYjLOK5y0bn-6ZI',
    appId: '1:991651846135:android:ac9723d0a6e38b2e4cc0f2',
    messagingSenderId: '991651846135',
    projectId: 'varinyprojectplanner',
    databaseURL: 'https://varinyprojectplanner-default-rtdb.firebaseio.com',
    storageBucket: 'varinyprojectplanner.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHeLOpY6je-CGSUSk5X47j0CfsgAo-Gs0',
    appId: '1:991651846135:ios:497957cff41017044cc0f2',
    messagingSenderId: '991651846135',
    projectId: 'varinyprojectplanner',
    databaseURL: 'https://varinyprojectplanner-default-rtdb.firebaseio.com',
    storageBucket: 'varinyprojectplanner.firebasestorage.app',
    iosBundleId: 'com.example.stemcalendar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHeLOpY6je-CGSUSk5X47j0CfsgAo-Gs0',
    appId: '1:991651846135:ios:497957cff41017044cc0f2',
    messagingSenderId: '991651846135',
    projectId: 'varinyprojectplanner',
    databaseURL: 'https://varinyprojectplanner-default-rtdb.firebaseio.com',
    storageBucket: 'varinyprojectplanner.firebasestorage.app',
    iosBundleId: 'com.example.stemcalendar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBb4ryXag-Di6vBOFHUL2b84383RydSdsk',
    appId: '1:991651846135:web:1fd292cea8b4605a4cc0f2',
    messagingSenderId: '991651846135',
    projectId: 'varinyprojectplanner',
    authDomain: 'varinyprojectplanner.firebaseapp.com',
    databaseURL: 'https://varinyprojectplanner-default-rtdb.firebaseio.com',
    storageBucket: 'varinyprojectplanner.firebasestorage.app',
    measurementId: 'G-Y3X76TVFNZ',
  );
}
