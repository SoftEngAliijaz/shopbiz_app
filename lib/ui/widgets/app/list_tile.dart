import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, this.leadingIcon, this.title, this.trailingIcon});

  final IconData? leadingIcon;
  final String? title;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: AppColors.kWhiteColor,
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          onTap: () {},
          leading: leadingIcon != null ? Icon(leadingIcon) : null,
          titleTextStyle: TextStyle(
              color: AppColors.kBlackColor, fontSize: screenWidth * 0.03),
          title: Text(title!),
          trailing: trailingIcon != null ? Icon(trailingIcon) : null,
        ),
      ),
    );
  }
}
