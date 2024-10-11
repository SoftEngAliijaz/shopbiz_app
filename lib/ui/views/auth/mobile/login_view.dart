import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/admin/screens/main/admin_dashboard_screen.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/admin_secret_key.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/sign_up_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_circle_div.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';
import 'package:social_auth_buttons/res/buttons/facebook_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';

class LogInMobileView extends StatefulWidget {
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final GlobalKey<FormState> formKey;

  const LogInMobileView({
    super.key,
    required this.emailEditingController,
    required this.passwordEditingController,
    required this.formKey,
  });

  @override
  State<LogInMobileView> createState() => _LogInMobileViewState();
}

class _LogInMobileViewState extends State<LogInMobileView> {
  bool _isPasswordObscured = true;
  bool isLoading = false;
  int _selectedOption = 2;

  bool get isAdmin => _selectedOption == 1;

  Future<UserCredential> _performLogin(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _loginCredentials(BuildContext context,
      {required bool isAdmin}) async {
    String email = widget.emailEditingController.text.trim();
    String password = widget.passwordEditingController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Email and password are required.");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackBar(context, "Please enter a valid email address.");
      return;
    }

    setState(() {
      isLoading = true;
    });

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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        AuthCircleDiv(size: size),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withOpacity(0.2)),
                  child: Form(
                    key: widget.formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.15),

                          // Logo
                          Container(
                            height: size.height * 0.15,
                            width: size.width * 0.15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/logos/main_logo.png'),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),

                          // Welcome text
                          Text('Welcome Back',
                              style: TextStyle(
                                  color: AppColors.kBlackColor,
                                  fontSize: size.width * 0.06)),
                          Text(
                            'Log in to your account using e-mail or social media',
                            style: TextStyle(
                                color: AppColors.kGreyColor,
                                fontSize: size.width * 0.035),
                          ),
                          SizedBox(height: size.height * 0.05),

                          // Facebook Log In
                          FacebookAuthButton(
                            padding: const EdgeInsets.all(10.0),
                            buttonColor: AppColors.kWhiteColor,
                            onPressed: () {},
                            textStyle: TextStyle(
                                fontSize: size.width * 0.04,
                                color: AppColors.kBlackColor),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Google Log In
                          GoogleAuthButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: () {},
                            textStyle: TextStyle(
                                color: AppColors.kBlackColor,
                                fontSize: size.width * 0.04),
                          ),
                          SizedBox(height: size.height * 0.06),

                          // Email and Password fields
                          CustomTextField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Field should not be empty ';
                              } else if (!isValidEmail(v)) {
                                return ' Enter valid email ';
                              }
                              return null;
                            },
                            hintText: 'Enter Email or Phone Number',
                            textEditingController:
                                widget.emailEditingController,
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(height: size.height * 0.02),

                          CustomTextField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Field should not be empty ';
                              }
                              return null;
                            },
                            obscureText: _isPasswordObscured,
                            hintText: 'Enter Password',
                            textEditingController:
                                widget.passwordEditingController,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                              icon: Icon(_isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          SizedBox(height: size.height * 0.002),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Radio<int>(
                                    activeColor: AppColors.kPrimaryColor,
                                    value: 1,
                                    groupValue: _selectedOption,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedOption = value!;
                                      });
                                    },
                                  ),
                                  Text('Admin'),
                                ],
                              ),
                              SizedBox(
                                  width:
                                      20), // Add space between the two options
                              Column(
                                children: [
                                  Radio<int>(
                                    activeColor: AppColors.kPrimaryColor,
                                    value: 2,
                                    groupValue: _selectedOption,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedOption = value!;
                                      });
                                    },
                                  ),
                                  Text('User'),
                                ],
                              ),

                              SizedBox(
                                width: 50,
                              ),

                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: size.width * 0.03),
                                ),
                              ),
                            ],
                          ),

                          // Forget password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [],
                          ),

                          CustomButton(
                            title: 'Login',
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await _loginCredentials(context,
                                  isAdmin: _selectedOption == 1);

                              setState(() {
                                isLoading = false; 
                              });
                            },
                          ),

                          SizedBox(height: size.height * 0.01),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: size.width * 0.03),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const SignUpScreen();
                                  }));
                                },
                                child: Text(
                                  'Sign Up Now',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: size.width * 0.03),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
