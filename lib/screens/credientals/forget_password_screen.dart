import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ///
  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: 'Password reset email sent successfully.');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ///controller
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///ttile
              const Text(
                'Forget Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ///Logo
              CircleAvatar(
                  radius: 100,
                  child: Image.asset('assets/images/e_commerce_logo.png')),

              ///Text fields
              const CustomTextField(
                textEditingController: null,
                prefixIcon: Icons.email_outlined,
                hintText: 'Enter Email',
              ),

              ///button
              CustomButton(
                title: 'Send Request',
                onPressed: () {
                  String email = emailController.text.trim();
                  resetPassword(context, email);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
