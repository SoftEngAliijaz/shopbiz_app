import 'package:flutter/material.dart';

class AuthLogoWidget extends StatelessWidget {
  const AuthLogoWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.999,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to  Online Shopbiz',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width * 0.025),
            ),
          ),
          const SizedBox(height: 20.0),
          Image.asset('assets/logos/main_logo.png',
              height: size.height * 0.15,
              width: size.width * 0.15,
              fit: BoxFit.contain),
        ],
      ),
    );
  }
}
