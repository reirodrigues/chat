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
    apiKey: 'AIzaSyAY7nZw88zRfF9h788a4kzBWoVbFTfsOig',
    appId: '1:382853132458:web:e04587496cfe93e24060d3',
    messagingSenderId: '382853132458',
    projectId: 'chat-flutter-rr-2023',
    authDomain: 'chat-flutter-rr-2023.firebaseapp.com',
    databaseURL: 'https://chat-flutter-rr-2023-default-rtdb.firebaseio.com',
    storageBucket: 'chat-flutter-rr-2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6cVPUkizRuLX-tkpejV9vh6bl1chCFeA',
    appId: '1:382853132458:android:19c09bcccd5c5ab34060d3',
    messagingSenderId: '382853132458',
    projectId: 'chat-flutter-rr-2023',
    databaseURL: 'https://chat-flutter-rr-2023-default-rtdb.firebaseio.com',
    storageBucket: 'chat-flutter-rr-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlj4REpR281sKUTYuhkepgTvd0uCrhXis',
    appId: '1:382853132458:ios:27d877237bc275344060d3',
    messagingSenderId: '382853132458',
    projectId: 'chat-flutter-rr-2023',
    databaseURL: 'https://chat-flutter-rr-2023-default-rtdb.firebaseio.com',
    storageBucket: 'chat-flutter-rr-2023.appspot.com',
    iosClientId: '382853132458-qa601vnvseqt2jb55bf9v2ucpgb8qed4.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlj4REpR281sKUTYuhkepgTvd0uCrhXis',
    appId: '1:382853132458:ios:27d877237bc275344060d3',
    messagingSenderId: '382853132458',
    projectId: 'chat-flutter-rr-2023',
    databaseURL: 'https://chat-flutter-rr-2023-default-rtdb.firebaseio.com',
    storageBucket: 'chat-flutter-rr-2023.appspot.com',
    iosClientId: '382853132458-qa601vnvseqt2jb55bf9v2ucpgb8qed4.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );
}
