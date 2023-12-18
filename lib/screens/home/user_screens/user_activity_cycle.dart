import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
import 'package:shopbiz_app/screens/home/home_screen.dart';

class UserActivityCycleScreen extends StatelessWidget {
  const UserActivityCycleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Waiting...'));
        }

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return const HomeScreen();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
