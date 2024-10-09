import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData trailingIcon;

  const UserInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ListTile(
      leading: CircleAvatar(),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(trailingIcon),
    ));
  }
}
