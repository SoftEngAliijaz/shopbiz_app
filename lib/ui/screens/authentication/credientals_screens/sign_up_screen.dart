import 'package:flutter/material.dart';
import 'package:shopbiz_app/ui/views/auth/desktop/signup_view.dart';
import 'package:shopbiz_app/ui/views/auth/mobile/signup_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController lastNameEditingController =
      TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController rePassEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Scaffold(
        body: res
            ? SignUpDesktopView(
                emailEditingController: emailEditingController,
                nameEditingController: nameEditingController,
                lastNameEditingController: lastNameEditingController,
                passwordEditingController: passwordEditingController,
                rePassEditingController: rePassEditingController,
                phoneEditingController: phoneEditingController,
                formKey: formKey,
              )
            : SignUpMobileView(
                emailEditingController: emailEditingController,
                nameEditingController: nameEditingController,
                lastNameEditingController: lastNameEditingController,
                passwordEditingController: passwordEditingController,
                rePassEditingController: rePassEditingController,
                phoneEditingController: phoneEditingController,
                formKey: formKey,
              ));
  }
}