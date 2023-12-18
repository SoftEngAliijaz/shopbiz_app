import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/screens/credientals/forget_password_screen.dart';
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
  bool? isObsecureText = false;

  ///onsub fform

  loginCredientals() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailC.text, password: _passwordC.text);

      if (userCredential.user != null) {
        //1. Retrieve user data from Firestore
        /* 
         DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
*/
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        /*
         if (userSnapshot.exists) {
         //   User data exists, you can extract and use it
           var userData = userSnapshot.data()!;
           // Update your UserModel with the retrieved data
           userSnapshot.get(userData);
         }

         2. Update user token or session (placeholder, implement your logic)
         updateToken(userCredential.user!.uid);
*/
        // 3. Navigate to Home Screen
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const HomeScreen();
        }));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User does not exist. Please sign up.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Incorrect password. Please try again.');
      } else {
        Fluttertoast.showToast(msg: 'Error: ${e.message}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
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
                        height: size.height * 0.90,
                        width: size.width,
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
                                child: Image.asset(
                                    'assets/images/e_commerce_logo.png')),

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
                              obscureText: isObsecureText,
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
                                    isObsecureText = !isObsecureText!;
                                  });
                                },
                                icon: Icon(
                                  isObsecureText == false
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),

                            ///button
                            CustomButton(
                              title: 'LOGIN',
                              onPressed: () {
                                loginCredientals();
                              },
                            ),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return ForgetPasswordScreen();
                                    }));
                                  },
                                  child: Text('Forget Password')),
                            ),

                            AccountSelection(
                              title: "Don't have Account?",
                              buttonTitle: 'CREATE ACCOUNT',
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return const SingUpScreen();
                                }));
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
