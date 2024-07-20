import 'package:adminapp/adminsignupscreen.dart';
import 'package:adminapp/adminlogin.dart'; // Import AdminLoginScreen
import 'package:adminapp/admindashboard.dart'; // Import AdminDashboardScreen
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'app_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  await firebaseAppCheck.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: AuthWrapper(), // Use AuthWrapper as the home screen
      routes: {
        '/admin-login': (context) => AdminLoginScreen(),
        '/admin-dashboard': (context) => AdminDashboard(), // Add this route
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return AdminDashboard();
        }
        return AdminSignupScreen();
      },
    );
  }
}
