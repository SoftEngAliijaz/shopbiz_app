import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class ProductCardTitle extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const ProductCardTitle({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      trailing: TextButton(
        onPressed: onPressed,
        child:
            Text("View all", style: TextStyle(color: AppColors.kPrimaryColor)),
      ),
    );
  }
}
