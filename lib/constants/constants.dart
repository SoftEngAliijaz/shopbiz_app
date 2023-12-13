import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstants {
  static TextStyle textBold() => const TextStyle(fontWeight: FontWeight.bold);

  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static const String splashScreenBgImg =
      'https://images.unsplash.com/photo-1702187600537-5eea13f96937?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  static Center customProgressIndicator() => Center(
          child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
      ));

  static TextStyle animationStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    );
  }
}



/*
AnimatedTextKit(
  animatedTexts: [
    TypewriterAnimatedText(
      'Hello world!',
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      speed: const Duration(milliseconds: 2000),
    ),
  ],
  
  totalRepeatCount: 4,
  pause: const Duration(milliseconds: 1000),
  displayFullTextOnTap: true,
  stopPauseOnTap: true,
)
*/