// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyC0S0XYk7Lherf5lTkWvdvnjEbkFymyV94',
  //   appId: '1:677440208167:web:cf7980c7968fdb98c93d02',
  //   messagingSenderId: '677440208167',
  //   projectId: 'firestore-root',
  //   authDomain: 'firestore-root.firebaseapp.com',
  //   storageBucket: 'firestore-root.appspot.com',
  // );

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['API_KEY'] ?? '',
    appId: dotenv.env['APP_ID'] ?? '',
    messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    authDomain: dotenv.env['AUTH_DOMAIN'],
    storageBucket: dotenv.env['STORAGE_BUCKET'],
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRSovg8qDqWdrPA9RUhSiswjxhAgri5Ow',
    appId: '1:677440208167:android:4b911255b2f5706ec93d02',
    messagingSenderId: '677440208167',
    projectId: 'firestore-root',
    storageBucket: 'firestore-root.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1rIgbl94DFH9mxTubKpYIUbLKtIvWCrQ',
    appId: '1:677440208167:ios:2f8ed2f5083a921dc93d02',
    messagingSenderId: '677440208167',
    projectId: 'firestore-root',
    storageBucket: 'firestore-root.appspot.com',
    iosClientId:
        '677440208167-gi5jqapkuak6q5ktdplslredjj69jg7o.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskFirebase',
  );
}
