import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';

class AppState with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await FirebaseAppCheck.instance.activate();
    }
  }
}