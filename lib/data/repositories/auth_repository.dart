import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/admin/screens/main/admin_dashboard_screen.dart';
import 'package:shopbiz_app/data/models/user_model.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/admin_secret_key.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';

class AuthRepository {
  AuthRepository({
    this.formKey,
    this.emailEditingController,
    this.passwordEditingController,
    this.rePassEditingController,
    this.context,
    this.phonEditingController,
    this.nameEditingController,
    this.image,
  });

  final formKey;
  final TextEditingController? emailEditingController;
  final TextEditingController? passwordEditingController;
  final TextEditingController? rePassEditingController;
  final TextEditingController? phonEditingController;
  final TextEditingController? nameEditingController;
  final BuildContext? context;
  File? image;

  Future<void> signUpCredentials(BuildContext context,
      {required bool isAdmin}) async {
    String email = emailEditingController!.text.trim();
    String password = passwordEditingController!.text.trim();
    String name = nameEditingController!.text.trim();
    String phoneNumber = phonEditingController!.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address.")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password must be at least 6 characters long.")),
      );
      return;
    }

    int? parsedPhoneNumber = int.tryParse(phoneNumber);
    if (parsedPhoneNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid phone number.")),
      );
      return;
    }

    try {
      if (isAdmin) {
        bool isKeyValid = await showAdminKeyDialog(context, isLogin: false);
        if (!isKeyValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Invalid admin secret key. Sign-up canceled.")),
          );
          return;
        }
      }

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? idToken = await userCredential.user?.getIdToken();

      Future<String?> _uploadImage() async {
        if (image == null) return null;

        try {
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('user_profile_pictures')
              .child(
                  '${emailEditingController!.text.trim()}_profile_picture.jpg');

          UploadTask uploadTask = ref.putFile(image!);

          await uploadTask;

          String downloadUrl = await ref.getDownloadURL();

          return downloadUrl;
        } catch (e) {
          print("Error uploading image: $e");
          return null;
        }
      }

      String? photoUrl;

      if (image != null) {
        photoUrl = await _uploadImage();
      }

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        profilePic: photoUrl ??
            'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg',
        phoneNumber: parsedPhoneNumber,
        isAdmin: isAdmin,
      );

      String collectionName = isAdmin ? "admins" : "users";

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userCredential.user!.uid)
          .set({
        ...userModel.toMap(),
        'idToken': idToken,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign-up successful!")),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LogInScreen()));
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage =
            "This email address is already in use. Please try another one.";
      } else {
        errorMessage = "Error: ${e.message}";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An unexpected error occurred.")));
    }
  }

  
// login function

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<UserCredential> _performLogin(String email, String password) async {
    
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginCredentials(BuildContext context,
      {required bool isAdmin}) async {
        if (emailEditingController == null || passwordEditingController == null) {
    _showSnackBar(context, "Email and password fields are not initialized.");
    return;
  }
    String email = emailEditingController!.text.trim();

    String password = passwordEditingController!.text.trim() ;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Email and password are required.");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackBar(context, "Please enter a valid email address.");
      return;
    }

    try {
      if (isAdmin) {
        bool isKeyValid = await showAdminKeyDialog(context, isLogin: true);
        if (!isKeyValid) {
          _showSnackBar(context, "Invalid admin secret key. Login canceled.");
          return;
        }
      }

      final userCredential = await _performLogin(email, password);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(isAdmin ? "admins" : "users")
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        _showSnackBar(context, "User does not exist.");
        return;
      }

      _showSnackBar(context, "Login successful!");

      if (isAdmin) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AdminDashboardScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided.";
      } else {
        errorMessage = "Error: ${e.message}";
      }

      _showSnackBar(context, errorMessage);
    } catch (e) {
      _showSnackBar(context, "An unexpected error occurred.");
    }
  }

  Future forgetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(content: Text('Reset link sent!')),
      );
    }
  }
}
