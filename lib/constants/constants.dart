import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstants {
  static TextStyle textBold() => const TextStyle(fontWeight: FontWeight.bold);

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
