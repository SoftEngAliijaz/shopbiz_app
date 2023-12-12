import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopbiz_app/credientals/login_screen.dart';
import 'package:shopbiz_app/credientals/signup_screen.dart';

class UserWayEntryScreen extends StatelessWidget {
  const UserWayEntryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/images (1).jpg'),
        ),
      ),
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'CHOOSE WHAT YOU WANT TO DO?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return SingUpScreen();
                        }));
                      },
                      child: Text(
                        "SIGNUP SCREEN",
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return LogInScreen();
                        }));
                      },
                      child: Text(
                        "LOGIN SCREEN",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
