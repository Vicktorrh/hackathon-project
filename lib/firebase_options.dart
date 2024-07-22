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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA01mNXKZrtTW6I7DX5iy7_FoylWf4YswA',
    appId: '1:900588325401:android:044d568084dd20eba27888',
    messagingSenderId: '900588325401',
    projectId: 'hackathon-project-4dca0',
    storageBucket: 'hackathon-project-4dca0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUFVja9t4HRAbRvFusYlDhGY7c6l4ZD1o',
    appId: '1:900588325401:ios:2b5d5b30e9768ac3a27888',
    messagingSenderId: '900588325401',
    projectId: 'hackathon-project-4dca0',
    storageBucket: 'hackathon-project-4dca0.appspot.com',
    androidClientId: '900588325401-q07bpd5ae783341u17vlocnb8rlhqhau.apps.googleusercontent.com',
    iosClientId: '900588325401-f242bmf96umi7u6enn3ssndoan0b4tp9.apps.googleusercontent.com',
    iosBundleId: 'com.vicktor.hackathanproject',
  );

}