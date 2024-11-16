import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class AuthCircleDiv extends StatelessWidget {
  const AuthCircleDiv({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: size.height * 0.30,
        width: size.height * 0.30,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kPrimaryColor,
              const Color(0xFF0EDCF8),
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10000),
          ),
        ),
      ),
    );
  }
}
