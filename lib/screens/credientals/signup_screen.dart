import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/models/user_model.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
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
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final TextEditingController _rePassC = TextEditingController();
  bool isObsecureText1 = false;
  bool isObsecureText2 = false;

  ///key
  var globalKey = GlobalKey<FormState>();

// Signup Screen
  signUpCredientals() async {
    if (globalKey.currentState!.validate()) {
      if (_passwordC.text != _rePassC.text) {
        Fluttertoast.showToast(msg: "Password did not match!");
        return null;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailC.text, password: _passwordC.text);

        if (userCredential.user != null) {
          UserModel userModel = UserModel(
            uid: FirebaseAuth.instance.currentUser!.uid,
            email: _emailC.text,
            displayName: _nameC.text,
          );

          // Successfully signed up, save user data to Firestore
          FirebaseFirestore.instance
              .collection('users')
              .doc(userModel.uid)
              .set(userModel.toMap());

          // Navigate to login screen
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const LogInScreen();
          }));
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Authentication exceptions
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'Email is already in use. Please sign in.');
        } else {
          Fluttertoast.showToast(msg: 'Error: ${e.message}');
        }
      } catch (e) {
        // Handle other exceptions
        Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: globalKey,
                    child: SingleChildScrollView(
                      child: Container(
                        height: size.height * 0.99,
                        width: size.width,
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
                                child: Image.asset(
                                    'assets/images/e_commerce_logo.png')),

                            ///Text fields

                            CustomTextField(
                              textEditingController: _nameC,
                              prefixIcon: Icons.person_outline,
                              hintText: 'Enter Name',
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Field Should Not be Empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
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
                              obscureText: isObsecureText1,
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
                              suffixWidget: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObsecureText1 =
                                        !isObsecureText1; // Use assignment operator here
                                  });
                                },
                                icon: Icon(
                                  isObsecureText1 == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            CustomTextField(
                              textEditingController: _rePassC,
                              prefixIcon: Icons.password_outlined,
                              obscureText: isObsecureText1,
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
                              suffixWidget: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObsecureText2 =
                                        !isObsecureText2; // Use assignment operator here
                                  });
                                },
                                icon: Icon(
                                  isObsecureText2 == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),

                            ///button
                            CustomButton(
                              title: 'SIGNUP',
                              onPressed: () {
                                signUpCredientals();
                              },
                            ),

                            ///selection
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
