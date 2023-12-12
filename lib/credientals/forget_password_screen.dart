import 'package:flutter/material.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ///
              Text(
                'Forget Password',
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
                textEditingController: null,
                prefixIcon: Icons.email_outlined,
                hintText: 'Enter Email',
              ),

              ///button
              CustomButton(
                title: 'Send Request',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
