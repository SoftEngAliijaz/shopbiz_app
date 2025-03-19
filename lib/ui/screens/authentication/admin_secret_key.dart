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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          isLogin ? 'Admin Login' : 'Admin Sign-Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: adminKeyController,
              decoration: InputDecoration(
                hintText: "Enter Secret Key",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Text(
              'Please enter the secret key provided by the administrator.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              if (adminKeyController.text == secretKey) {
                isValidKey = true;
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid Secret Key. Please try again.'),
                    backgroundColor: Colors.redAccent
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
