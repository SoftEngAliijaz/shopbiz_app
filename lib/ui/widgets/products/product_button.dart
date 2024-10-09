import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class ProductButton extends StatefulWidget {
  final String title;
  final IconData? productIcon;
  final void Function()? onPressed;

  const ProductButton({
    super.key,
    required this.title,
    required this.productIcon,
    this.onPressed,
  });

  @override
  State<ProductButton> createState() => _ProductButtonState();
}

class _ProductButtonState extends State<ProductButton> {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    final responsive = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(100.0)),
        child: TextButton.icon(
          label: Text(widget.title,
              overflow: TextOverflow.ellipsis,
              textAlign: responsive ? TextAlign.center : TextAlign.center,
              style: TextStyle(color: AppColors.kWhiteColor)),
          icon: Icon(widget.productIcon, color: AppColors.kWhiteColor),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
