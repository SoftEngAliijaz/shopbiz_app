import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/repositories/auth_repository.dart';
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
  // For toggling password visibility
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background gradient shape
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

                          // Forget password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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

                          // Log In button
                          CustomButton(
                              title: 'Login',
                              onPressed: () async {
                                await AuthRepository().loginFormSubmission();
                              }),

                          SizedBox(height: size.height * 0.01),

                          // Sign up text button
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
