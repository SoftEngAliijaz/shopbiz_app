import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/repositories/auth_repository.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_circle_div.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class SignUpMobileView extends StatefulWidget {
  const SignUpMobileView({
    super.key,
    required this.emailEditingController,
    required this.nameEditingController,
    required this.lastNameEditingController,
    required this.passwordEditingController,
    required this.rePassEditingController,
    required this.phoneEditingController,
    required this.formKey,
  });

  final TextEditingController emailEditingController;
  final GlobalKey<FormState> formKey;
  final TextEditingController lastNameEditingController;
  final TextEditingController nameEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController phoneEditingController;
  final TextEditingController rePassEditingController;

  @override
  State<SignUpMobileView> createState() => _SignUpMobileViewState();
}

class _SignUpMobileViewState extends State<SignUpMobileView> {
  bool _isPasswordObscured = true;
  bool _rePasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Background shape for aesthetics (optional)
        AuthCircleDiv(size: size),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.2)),
              child: Form(
                key: widget.formKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height:
                              size.height * 0.15), // Adjust to fit under shape
                      Container(
                        height: size.height * 0.15,
                        width: size.width * 0.15,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logos/main_logo.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Create New Account',
                        style: TextStyle(
                            color: AppColors.kBlackColor,
                            fontSize: size.width * 0.06),
                      ),
                      Text(
                        'Set up your user name and password\nYou can always change it later',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.kGreyColor,
                            fontSize: size.width * 0.035),
                      ),
                      SizedBox(height: size.height * 0.05),

                      // Name TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          }
                          return null;
                        },
                        hintText: 'First Name',
                        textEditingController: widget.nameEditingController,
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Last Name TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          }
                          return null;
                        },
                        hintText: 'Last Name',
                        textEditingController: widget.lastNameEditingController,
                        prefixIcon: Icons.person_outline,
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Phone TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          }
                          return null;
                        },
                        hintText: 'Phone Number',
                        textEditingController: widget.phoneEditingController,
                        prefixIcon: Icons.phone_outlined,
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Email TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          } else if (!isValidEmail(v)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        hintText: 'Email',
                        textEditingController: widget.emailEditingController,
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Password TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          } else if (v.length < 6) {
                            return '  password should contain 6 digits ';
                          }
                          return null;
                        },
                        obscureText: _isPasswordObscured,
                        hintText: 'Password',
                        textEditingController: widget.passwordEditingController,
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
                      SizedBox(height: size.height * 0.02),

                      // Re-enter Password TextField
                      CustomTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Field should not be empty ';
                          } else if (v.length < 6) {
                            return '  password should contain 6 digits ';
                          }
                          return null;
                        },
                        obscureText: _rePasswordObscured,
                        hintText: 'Re-enter Password',
                        textEditingController: widget.rePassEditingController,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _rePasswordObscured = !_rePasswordObscured;
                            });
                          },
                          icon: Icon(_rePasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),

                      // Sign Up Button
                      CustomButton(
                        title: 'Sign Up',
                        onPressed: () async {
                          await AuthRepository().signUpFormSubmission();
                        },
                      ),
                      SizedBox(height: size.height * 0.01),

                      // Log In Text Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: AppColors.kBlackColor,
                                fontSize: size.width * 0.03),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const LogInScreen();
                              }));
                            },
                            child: Text(
                              'Log In',
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
        ),
      ],
    );
  }
}
