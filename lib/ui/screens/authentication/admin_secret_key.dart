import 'package:flutter/material.dart';

const String signUpSecretKey = 'Shopbiz-Admin';
const String loginSecretKey = 'Shopbiz-App';

Future<bool> showAdminKeyDialog(BuildContext context,
    {required bool isLogin}) async {
  final TextEditingController adminKeyController = TextEditingController();
  bool isValidKey = false;
  String secretKey = isLogin ? loginSecretKey : signUpSecretKey;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(isLogin ? 'Admin Login' : 'Admin Sign-Up'),
        content: TextField(
          controller: adminKeyController,
          decoration: InputDecoration(hintText: "Enter Secret Key"),
          obscureText: true,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              if (adminKeyController.text == secretKey) {
                isValidKey = true;
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid Secret Key. Please try again.'),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );

  return isValidKey;
}
