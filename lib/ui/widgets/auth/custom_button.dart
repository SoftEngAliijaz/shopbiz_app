import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: responsive ? size.height * 0.060 : size.height * 0.060,
      width: responsive ? size.width * 0.280 : size.width * 0.70,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          backgroundColor: WidgetStateProperty.all(AppColors.kPrimaryColor),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: AppColors.kWhiteColor, fontSize: 18.0),
        ),
      ),
    );
  }
}
