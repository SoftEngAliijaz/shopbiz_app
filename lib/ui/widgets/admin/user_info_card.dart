import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  final String subtitle;
  final String title;
  final IconData trailingIcon;

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
