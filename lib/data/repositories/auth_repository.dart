import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';

class AuthRepository {
  AuthRepository({
    this.formKey,
    this.emailEditingController,
    this.passwordEditingController,
    this.rePassEditingController,
    this.context,
  });

  final context;
  final emailEditingController;
  final formKey;
  final passwordEditingController;
  final rePassEditingController;

  Future<void> signUpFormSubmission() async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailEditingController.text.trim();
      final password = passwordEditingController.text.trim();
      final rePassword = rePassEditingController.text.trim();

      if (password != rePassword) {
        errorDialog(context, 'Passwords do not match');
        return;
      }

      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInScreen()));
        });
      } catch (e) {
        debugPrint('Error: $e');
        errorDialog(context, e.toString());
      }
    }
  }

  Future<void> loginFormSubmission() async {
    final email = emailEditingController.text.trim();
    final password = passwordEditingController.text;

    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else {
          message = 'Something went wrong. Please try again.';
        }

        await errorDialog(context, title: 'Log In Error', message);
      } catch (e) {
        await errorDialog(
            context, 'An unexpected error occurred. Please try again.');
      }
    }
  }

  Future forgetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reset link sent!')),
      );
    }
  }
}
