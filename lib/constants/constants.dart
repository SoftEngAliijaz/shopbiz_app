import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstants {
  ///bold text method
  static TextStyle textBold() => const TextStyle(fontWeight: FontWeight.bold);

  ///flutter toast met
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  ///splash screen bg img
  static const String splashScreenBgImg =
      'https://images.unsplash.com/photo-1702187600537-5eea13f96937?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  ///CircularProgressIndicator
  static Center customProgressIndicator() => const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
      ));

  ///animation styles
  static TextStyle animationStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
  }
}
