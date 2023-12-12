import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstants {
  static TextStyle textBold() => const TextStyle(fontWeight: FontWeight.bold);

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
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