import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.textEditingController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
