import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/firebase_options.dart';

class EnvConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
