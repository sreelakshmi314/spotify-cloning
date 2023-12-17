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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCf6bD43Y-ofwRhjJfdWVjt49nTmEUWr1c',
    appId: '1:777686737675:web:a94c3e136a06187d3a780e',
    messagingSenderId: '777686737675',
    projectId: 'flutter-clone-app-c806d',
    authDomain: 'flutter-clone-app-c806d.firebaseapp.com',
    storageBucket: 'flutter-clone-app-c806d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0Fj1CGVMccB5AEypPyLDw-ppHCr1nkCo',
    appId: '1:777686737675:android:80745560aa97d0753a780e',
    messagingSenderId: '777686737675',
    projectId: 'flutter-clone-app-c806d',
    storageBucket: 'flutter-clone-app-c806d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBP-NtAvJHDoFk26CZdjcY3f-9P4DVg5Go',
    appId: '1:777686737675:ios:4b106902dfdc7acd3a780e',
    messagingSenderId: '777686737675',
    projectId: 'flutter-clone-app-c806d',
    storageBucket: 'flutter-clone-app-c806d.appspot.com',
    iosBundleId: 'com.example.spotifyCloning',
  );
}
