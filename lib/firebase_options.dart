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
    apiKey: 'AIzaSyB6Ow8hLzhpsaflOof4G3JZBHhqpN_iyTk',
    appId: '1:69385362933:web:4dd7ab2a1d27bc66dad4bc',
    messagingSenderId: '69385362933',
    projectId: 'biblexmovil',
    authDomain: 'biblexmovil.firebaseapp.com',
    storageBucket: 'biblexmovil.appspot.com',
    measurementId: 'G-5NV43H4KH8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfJpFcQOsoMmSmVkdytU8y21T0lbLFRks',
    appId: '1:69385362933:android:08a5d3b4f33cd5ccdad4bc',
    messagingSenderId: '69385362933',
    projectId: 'biblexmovil',
    storageBucket: 'biblexmovil.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzYTdQBTwb82-0rdgCQSWRM_3iUCY0Ftc',
    appId: '1:69385362933:ios:7fb5e5203e0dc607dad4bc',
    messagingSenderId: '69385362933',
    projectId: 'biblexmovil',
    storageBucket: 'biblexmovil.appspot.com',
    iosClientId: '69385362933-5t9f5b5sbn83pu7p4on3mjeonh3kf6p5.apps.googleusercontent.com',
    iosBundleId: 'com.ronytuquizz.bibleando',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzYTdQBTwb82-0rdgCQSWRM_3iUCY0Ftc',
    appId: '1:69385362933:ios:8369407d89bb0b12dad4bc',
    messagingSenderId: '69385362933',
    projectId: 'biblexmovil',
    storageBucket: 'biblexmovil.appspot.com',
    iosClientId: '69385362933-t1bv71j4u6tn8kt833m6cqsai77qo442.apps.googleusercontent.com',
    iosBundleId: 'com.ronytuquizz.bibleando3',
  );
}
