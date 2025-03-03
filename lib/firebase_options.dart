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
    apiKey: 'AIzaSyD8KtYERePwOqLe-l2eApfk5WKbvJI1lOY',
    appId: '1:626774704920:web:a9fa7c59cd01a7773d546d',
    messagingSenderId: '626774704920',
    projectId: 'nutriflow-project',
    authDomain: 'nutriflow-project.firebaseapp.com',
    storageBucket: 'nutriflow-project.firebasestorage.app',
    measurementId: 'G-3ST0LBL62N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB30mcNbwuQzwg4yfvPMNBn7JEpUqdPoLE',
    appId: '1:626774704920:android:75ae17ff9977e0d53d546d',
    messagingSenderId: '626774704920',
    projectId: 'nutriflow-project',
    storageBucket: 'nutriflow-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCX7lJ46TYTR95lKo0kDgWleO3rtP7B5x8',
    appId: '1:626774704920:ios:2d7fcee5199f22993d546d',
    messagingSenderId: '626774704920',
    projectId: 'nutriflow-project',
    storageBucket: 'nutriflow-project.firebasestorage.app',
    androidClientId: '626774704920-vc7bfdgdl23hamiukklm38eds52iqqs6.apps.googleusercontent.com',
    iosClientId: '626774704920-kv61kmkfdrhadjjilt94maqbbriae8n3.apps.googleusercontent.com',
    iosBundleId: 'com.example.nutriflowApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCX7lJ46TYTR95lKo0kDgWleO3rtP7B5x8',
    appId: '1:626774704920:ios:2d7fcee5199f22993d546d',
    messagingSenderId: '626774704920',
    projectId: 'nutriflow-project',
    storageBucket: 'nutriflow-project.firebasestorage.app',
    androidClientId: '626774704920-vc7bfdgdl23hamiukklm38eds52iqqs6.apps.googleusercontent.com',
    iosClientId: '626774704920-kv61kmkfdrhadjjilt94maqbbriae8n3.apps.googleusercontent.com',
    iosBundleId: 'com.example.nutriflowApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8KtYERePwOqLe-l2eApfk5WKbvJI1lOY',
    appId: '1:626774704920:web:660160d13c32598d3d546d',
    messagingSenderId: '626774704920',
    projectId: 'nutriflow-project',
    authDomain: 'nutriflow-project.firebaseapp.com',
    storageBucket: 'nutriflow-project.firebasestorage.app',
    measurementId: 'G-9R11H5VPYF',
  );
}
