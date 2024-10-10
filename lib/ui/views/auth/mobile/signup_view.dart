import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbiz_app/data/models/user_model.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';

class SignUpMobileView extends StatefulWidget {
  @override
  _SignUpMobileViewState createState() => _SignUpMobileViewState();
}

class _SignUpMobileViewState extends State<SignUpMobileView> {
  bool _isObscurePassword1 = true;
  bool _isObscurePassword2 = true;
  bool _isLoading = false;
  File? _image;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Future<void> _signUpCredentials(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController1.text;
    String name = nameController.text;
    String phoneNumber = phoneController.text;

    setState(() {
      _isLoading = true; // Start loading state
    });

    try {
      // Create user with email and password
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the ID token for the user
      String? idToken = await userCredential.user?.getIdToken();

      // Optionally upload the user's photo
      String? photoUrl;
      if (_image != null) {
        photoUrl = await _uploadImage();
      }

      // Create the UserModel
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        profilePic: photoUrl ??
            'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg',
        phoneNumber: phoneNumber,
      );

      // Store user details along with the ID token in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        ...userModel.toMap(), // Use the UserModel's toMap method
        'idToken': idToken, // Store the token
      });

      // Show success message and navigate to home screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign-up successful!")),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // Handle sign-up errors
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage =
            "This email address is already in use. Please try another one.";
        // Optionally redirect to login screen
      } else {
        errorMessage = "Error: ${e.message}";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      // Handle any other errors
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An unexpected error occurred.")));
    } finally {
      // End the loading state
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_image == null) return null; // Return null if no image is selected

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('user_profile_pictures')
          .child('${emailController.text.trim()}_profile_picture.jpg');

      UploadTask uploadTask = ref.putFile(_image!);

      await uploadTask;

      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      Fluttertoast.showToast(msg: 'Image Not Picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController1,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscurePassword1
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscurePassword1 = !_isObscurePassword1;
                      });
                    },
                  ),
                ),
                obscureText: _isObscurePassword1,
              ),
              TextField(
                controller: passwordController2,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscurePassword2
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscurePassword2 = !_isObscurePassword2;
                      });
                    },
                  ),
                ),
                obscureText: _isObscurePassword2,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _signUpCredentials(context);
                },
                child:
                    _isLoading ? CircularProgressIndicator() : Text("Sign Up"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImage,
                child: Text("Pick Profile Picture"),
              ),
              if (_image != null) ...[
                SizedBox(height: 20),
                Image.file(_image!, height: 100), // Display selected image
              ],
            ],
          ),
        ),
      ),
    );
  }
}
