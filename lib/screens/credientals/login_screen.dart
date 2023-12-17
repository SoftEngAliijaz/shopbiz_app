import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/screens/credientals/signup_screen.dart';
import 'package:shopbiz_app/screens/home/home_screen.dart';
import 'package:shopbiz_app/widgets/account_selection.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  var globalKey = GlobalKey<FormState>();

  ///onsub fform

  onSub() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailC.text, password: _passwordC.text);
      // Successfully signed in, you can access user information using userCredential.user
      // ignore: unnecessary_null_comparison
      userCredential != null
          // ignore: use_build_context_synchronously
          ? Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const HomeScreen();
            }))
          : null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle the case where user doesn't exist
        Fluttertoast.showToast(msg: 'User does not exist. Please sign up.');
      } else if (e.code == 'wrong-password') {
        // Handle the case where the password is incorrect
        Fluttertoast.showToast(msg: 'Incorrect password. Please try again.');
      } else {
        // Handle other exceptions
        Fluttertoast.showToast(msg: 'Error: ${e.message}');
      }
    } catch (e) {
      // Handle other exceptions
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///
                const Text(
                  'WELCOME TO\nE-Commerce App',
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
                CustomTextField(
                  textEditingController: _emailC,
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Enter Email',
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field Should Not be Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextField(
                  textEditingController: _passwordC,
                  prefixIcon: Icons.password_outlined,
                  hintText: 'Enter Password',
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field Should Not be Empty';
                    } else if (v.length < 5) {
                      return 'Invalid Length';
                    } else {
                      return null;
                    }
                  },
                ),

                ///button
                CustomButton(
                  title: 'LOGIN',
                  onPressed: () {
                    onSub();
                  },
                ),

                AccountSelection(
                  title: "Don't have Account?",
                  buttonTitle: 'CREATE ACCOUNT',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const SingUpScreen();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
