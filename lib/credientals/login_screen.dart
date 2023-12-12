import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/credientals/signup_screen.dart';
import 'package:shopbiz_app/screens/home_screen.dart';
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

  onSub() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailC.text, password: _passwordC.text);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return HomeScreen();
    }));
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
                Text(
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
                      return SingUpScreen();
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
