import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
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
          return Center(child: AppUtils.customProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Waiting for Connection...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          // Display an error message on the UI
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Navigate to HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Navigate to LogInScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LogInScreen()),
          );
        }

        // Placeholder, the actual widget returned won't be used
        return Container();
      },
    );
  }
}
