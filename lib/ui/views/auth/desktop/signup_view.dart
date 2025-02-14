import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/repositories/auth_repository.dart';
import 'package:shopbiz_app/ui/screens/authentication/log_in_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_clipper.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_logo.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_title_text.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class SignUpDesktopView extends StatefulWidget {
  const SignUpDesktopView({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.lastNameEditingController,
    required this.nameController,
    required this.passwordController1,
    required this.passwordController2,
    required this.formKey,
    required TextEditingController emailEditingController,
    required TextEditingController nameEditingController,
    required TextEditingController passwordEditingController,
    required TextEditingController rePassEditingController,
    required TextEditingController phoneEditingController,
  });

  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final TextEditingController lastNameEditingController;
  final TextEditingController nameController;
  final TextEditingController passwordController1;
  final TextEditingController passwordController2;
  final TextEditingController phoneController;

  @override
  State<SignUpDesktopView> createState() => _SignUpDesktopViewState();
}

class _SignUpDesktopViewState extends State<SignUpDesktopView> {
  bool _isChecked = false;
  bool _isPasswordObscured = true;
  int _selectedOption = 2;

  bool get isAdmin => _selectedOption == 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AuthTitleText(
                                        size: size,
                                        title: 'Sign Up',
                                        isCenterNeeded: false),
                                    SizedBox(height: size.height * 0.03),
                                    CustomTextField(
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else
                                          return null;
                                      },
                                      textEditingController:
                                          widget.nameController,
                                      prefixIcon: Icons.person_outline,
                                      hintText: 'First name',
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    CustomTextField(
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else
                                          return null;
                                      },
                                      textEditingController:
                                          widget.lastNameEditingController,
                                      prefixIcon: Icons.person_outline,
                                      hintText: 'Last name',
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    CustomTextField(
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else if (!isValidEmail(v)) {
                                          return 'enter a valid email ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      textEditingController:
                                          widget.emailController,
                                      hintText: 'Enter your e-mail',
                                      prefixIcon: Icons.email_outlined,
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    CustomTextField(
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else if (v.length > 6) {
                                          return 'password should contains 6 digits ';
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icons.lock_outline,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordObscured =
                                                !_isPasswordObscured;
                                          });
                                        },
                                        icon: Icon(_isPasswordObscured
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined),
                                      ),
                                      textEditingController:
                                          widget.passwordController1,
                                      hintText: 'Enter your password',
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    CustomTextField(
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'filed should not be empty ';
                                        } else if (v.length > 6) {
                                          return 'password should contains 6 digits ';
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icons.lock_outline,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isPasswordObscured =
                                                !_isPasswordObscured;
                                          });
                                        },
                                        icon: Icon(_isPasswordObscured
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined),
                                      ),
                                      textEditingController:
                                          widget.passwordController2,
                                      hintText: 'Re-enter your password',
                                      hintTextStyle: TextStyle(
                                          fontSize: size.width * 0.015,
                                          color: AppColors.kGreyColor),
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
                                    SizedBox(height: size.height * 0.02),
                                    CustomButton(
                                      title: 'Sign Up',
                                      onPressed: () async {
                                        bool isAdmin = _selectedOption == 1;
                                        await AuthRepository(
                                                emailEditingController:
                                                    widget.emailController,
                                                passwordEditingController:
                                                    widget.passwordController1,
                                                rePassEditingController:
                                                    widget.passwordController2,
                                                phonEditingController:
                                                    widget.phoneController,
                                                nameEditingController:
                                                    widget.nameController)
                                            .signUpCredentials(context,
                                                isAdmin: isAdmin);
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                            color: AppColors.kBlackColor,
                                            fontSize: size.width * 0.012,
                                          ),
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
                                              color: AppColors.kBlueColor,
                                              fontSize: size.width * 0.012,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
