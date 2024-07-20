import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:globalapp/registrationscreen.dart';
import 'package:globalapp/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: SplashScreen(),
    );
  }
}

