import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/credientals/login_screen.dart';
import 'package:shopbiz_app/widgets/account_selection.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  ///controllers
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final TextEditingController _rePassC = TextEditingController();

  ///key
  var globalKey = GlobalKey<FormState>();

  ///function
  onSubmittion() async {
    if (globalKey.currentState!.validate()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailC.text, password: _passwordC.text);
      if (_passwordC.text != _rePassC.text) {
        return 'Password Did not Match!';
      }
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return LogInScreen();
      }));
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
                Text(
                  'WELCOME TO\nE-Commerce App\nCreate Your Account',
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
                CustomTextField(
                  textEditingController: _rePassC,
                  prefixIcon: Icons.password_outlined,
                  hintText: 'Re-Enter Password',
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
                  title: 'SIGNUP',
                  onPressed: () {
                    onSubmittion();
                  },
                ),

                ///
                AccountSelection(
                  title: 'Already have account?',
                  buttonTitle: 'LOGIN',
                  onPressed: () {
                    Navigator.pop(context);
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
