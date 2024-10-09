import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

Future<dynamic> errorDialog(BuildContext context, String message,
    {String title = 'Sign Up Error'}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(title),
        content: Text(
          message,
          style: TextStyle(color: AppColors.kBlackColor, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// for email
bool isValidEmail(String email) {
  const String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}

String formatPhoneNumber(String phoneNumber) {
  // Assuming the phone number is Pakistani and starts with '0'
  if (phoneNumber.startsWith('0')) {
    return '+92${phoneNumber.substring(1)}';
  }
  return phoneNumber; // In case the phone number is already in correct format
}
