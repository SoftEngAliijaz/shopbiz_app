import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.textEditingController,
    this.validator,
    this.obscureText = false,
    this.hintTextStyle,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
  });

  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final TextStyle? hintTextStyle;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final res = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: 10.0, horizontal: res ? 30.0 : 5.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        style: TextStyle(color: AppColors.kBlackColor),
        validator: widget.validator,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          prefixIcon: Icon(widget.prefixIcon),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kBlackColor)),
          hintText: widget.hintText,
          labelStyle: TextStyle(color: AppColors.kBlackColor),
          hintStyle:
              widget.hintTextStyle ?? TextStyle(color: AppColors.kGreyColor),
        ),
      ),
    );
  }
}
