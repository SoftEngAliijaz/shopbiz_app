import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/data/models/user_model.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/admin_secret_key.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';

class AuthRepository {
  AuthRepository({
    this.formKey,
    this.emailEditingController,
    this.passwordEditingController,
    this.rePassEditingController,
    this.context,
    this.phonEditingController,
    this.nameEditingController,
  });

  final context;
  final emailEditingController;
  final formKey;
  final passwordEditingController;
  final rePassEditingController;
  final phonEditingController;
  final nameEditingController;
  Future<void> signUpFormSubmission({bool isAdmin = false}) async {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailEditingController.text.trim();
      final password = passwordEditingController.text.trim();
      final rePassword = rePassEditingController.text.trim();
      final phoneNumber = phonEditingController.text.trim();
      final name = nameEditingController.text.trim();
      // Assuming you have a controller for phone number

      // Validate phone number and ensure it's a valid integer
      if (phoneNumber == null) {
        errorDialog(context, 'Invalid phone number');
        return;
      }

      // Check if passwords match
      if (password != rePassword) {
        errorDialog(context, 'Passwords do not match');
        return;
      }

      try {
        // Create user with email and password
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String? photoUrl;
        // if (_image != null) {
        //   photoUrl = await _uploadImage();
        // }

        // Create the UserModel
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          name: name, // Ensure you have a name field
          email: email,
          profilePic: photoUrl ??
              'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg',
          phoneNumber: phoneNumber, // Convert phone number to int
          isAdmin: isAdmin, // Set isAdmin based on the sign-up type
        );

        // Determine the Firestore collection based on admin status
        String collectionName = isAdmin ? "admins" : "users";

        // Store user details in Firestore
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(userCredential.user!.uid)
            .set(userModel.toMap());

        // Navigate to login screen after successful sign-up
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      } catch (e) {
        debugPrint('Error: $e');
        errorDialog(context, e.toString());
      }
    }
  }
Future<void> loginFormSubmission({bool isAdmin = false}) async {
  final email = emailEditingController.text.trim();
  final password = passwordEditingController.text;

  // Validate the form
  if (formKey.currentState!.validate()) {
    try {
      // If the user is attempting to log in as an admin
      if (isAdmin) {
        // Prompt for admin key
        bool isKeyValid = await showAdminKeyDialog(context, isLogin: true);
        if (!isKeyValid) {
          // If the admin key is invalid, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid admin secret key.")),
          );
          return; // Exit if the key is not valid
        }
      }

      // Proceed with Firebase authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home screen upon successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'Something went wrong. Please try again.';
      }

      // Show an error dialog for authentication errors
      await errorDialog(context, title: 'Log In Error',  message);
    } catch (e) {
      // Handle any unexpected errors
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
