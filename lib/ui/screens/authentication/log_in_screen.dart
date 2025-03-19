import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopbiz_app/ui/screens/app/home/home_screen.dart';
import 'package:shopbiz_app/ui/views/auth/desktop/login_view.dart';
import 'package:shopbiz_app/ui/views/auth/mobile/login_view.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  void checkValidations() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Scaffold(
        body: res
            ? LogInDesktopView(
                emailEditingController: emailEditingController,
                passwordEditingController: passwordEditingController,
                formKey: formKey,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const HomeScreen();
                  }));
                },
              )
            : LogInMobileView(
                formKey: formKey,
                emailEditingController: emailEditingController,
                passwordEditingController: passwordEditingController));
  }
}
