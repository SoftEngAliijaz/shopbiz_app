import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopbiz_app/screens/initial_screen/user_way_entry_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  ///
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return UserWayEntryScreen();
      }));
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///logo
            Container(
              child: const CircleAvatar(
                radius: 100,
                backgroundImage:
                    AssetImage('assets/images/e_commerce_logo.png'),
              ),
            ),
            SizedBox(height: 20),

            ///title
            Text(
              'WELCOME TO SHOPBIZ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            ///progress bar
            Container(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
