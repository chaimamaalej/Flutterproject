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
    apiKey: 'AIzaSyBUXlmV695XkUJ-LCHe8Z7zlbteAJs-Vak',
    appId: '1:985591345839:web:cf3a9c2d43ca66f7099a5a',
    messagingSenderId: '985591345839',
    projectId: 'fir-stage-c9ada',
    authDomain: 'fir-stage-c9ada.firebaseapp.com',
    storageBucket: 'fir-stage-c9ada.appspot.com',
    measurementId: 'G-EV8WHZ6V2R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFW7Ou5F_q3r0buL9_Msf-qzUdZ78c5Us',
    appId: '1:985591345839:android:05cd2cd093d49f20099a5a',
    messagingSenderId: '985591345839',
    projectId: 'fir-stage-c9ada',
    storageBucket: 'fir-stage-c9ada.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwByq4IhTleJZIhGjjJEsOAmhtxYwDTQM',
    appId: '1:985591345839:ios:220b675608891c7e099a5a',
    messagingSenderId: '985591345839',
    projectId: 'fir-stage-c9ada',
    storageBucket: 'fir-stage-c9ada.appspot.com',
    iosClientId: '985591345839-gcas1js5mq5pmpfin2iiqci6rug2eddk.apps.googleusercontent.com',
    iosBundleId: 'com.example.stage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwByq4IhTleJZIhGjjJEsOAmhtxYwDTQM',
    appId: '1:985591345839:ios:fa458b9743b669ad099a5a',
    messagingSenderId: '985591345839',
    projectId: 'fir-stage-c9ada',
    storageBucket: 'fir-stage-c9ada.appspot.com',
    iosClientId: '985591345839-d7jrd7qij8dv2ummclqbnet16rn7ptom.apps.googleusercontent.com',
    iosBundleId: 'com.example.stage.RunnerTests',
  );
}
