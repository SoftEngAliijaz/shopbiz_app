import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class AuthTitleText extends StatelessWidget {
  final Size size;
  final String title;
  final bool isCenterNeeded;

  const AuthTitleText({
    super.key,
    required this.size,
    required this.title,
    required this.isCenterNeeded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 60.0),
      child: Align(
        alignment:
            isCenterNeeded == true ? Alignment.center : Alignment.topLeft,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.03),
            ),
            Container(
              width: size.width * 0.1,
              height: size.height * 0.01,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.kBlueColor, AppColors.kGreyColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
