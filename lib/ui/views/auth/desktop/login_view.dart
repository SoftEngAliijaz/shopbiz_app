import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/repositories/auth_repository.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/sign_up_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_clipper.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_logo.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_title_text.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class LogInDesktopView extends StatefulWidget {
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final GlobalKey<FormState> formKey;
  final void Function()? onPressed;

  const LogInDesktopView({
    super.key,
    required this.emailEditingController,
    required this.passwordEditingController,
    required this.formKey,
    required this.onPressed,
  });

  @override
  State<LogInDesktopView> createState() => _LogInDesktopViewState();
}

class _LogInDesktopViewState extends State<LogInDesktopView> {
  bool _isPasswordObscured = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            child: Form(
              key: widget.formKey,
              child: Row(
                children: [
                  Expanded(child: AuthLogoWidget(size: size)),
                  Expanded(
                    child: ClipPath(
                      clipper: AuthClipper(),
                      child: Container(
                        height: size.height,
                        width: size.width,
                        color: AppColors.kPrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 100.0,
                              top: 50.0,
                              bottom: 50.0,
                              right: 25.0),
                          child: Card(
                            color: Theme.of(context).cardColor,
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AuthTitleText(
                                        size: size,
                                        title: 'Login',
                                        isCenterNeeded: false),
                                    SizedBox(height: size.height * 0.10),
                                    CustomTextField(
                                      textEditingController:
                                          widget.emailEditingController,
                                      prefixIcon: Icons.email_outlined,
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                      hintText: 'Enter Email',
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else if (!isValidEmail(v)) {
                                          return 'enter a valid email ';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    CheckboxMenuButton(
                                        value: true,
                                        onChanged: (v) {},

                                        /// if user selected "yes"
                                        /// it should show a field that will ask to enter a secret code that only admin knows
                                        /// if secretCode == 'SuperMan'
                                        /// then it will check if admin enters correct secret code it will allow to use our app
                                        /// our app as a admin and also show Admin dashboard
                                        /// NOTE: (Secret Code for Admin SignUp & Admin Login will be different)
                                        /// make admin's collection separate and user's separate
                                        child: Text('Are you a admin')),
                                    CustomTextField(
                                      textEditingController:
                                          widget.passwordEditingController,
                                      obscureText: _isPasswordObscured,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordObscured =
                                                !_isPasswordObscured;
                                          });
                                        },
                                        icon: Icon(_isPasswordObscured
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                      prefixIcon: Icons.lock_outline,
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                      hintText: 'Enter Password',
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'field should not be empty ';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, right: 25.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Checkbox(
                                                activeColor:
                                                    AppColors.kPrimaryColor,
                                                checkColor:
                                                    AppColors.kWhiteColor,
                                                value: _isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _isChecked = value ?? false;
                                                  });
                                                },
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'By signing in you accept the Terms of services and Privacy Policy',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.012),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    CustomButton(
                                      title: 'Login',
                                      onPressed: () async {
                                        AuthRepository().loginFormSubmission();
                                      },
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            color: AppColors.kBlackColor,
                                            fontSize: size.width * 0.01,
                                          ),
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
                                              color: AppColors.kBlueColor,
                                              fontSize: size.width * 0.01,
                                            ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
