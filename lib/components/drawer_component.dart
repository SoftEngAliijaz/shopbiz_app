import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
import 'package:shopbiz_app/screens/home/user_screens/profile_screen.dart';

class Components {
  ///firebase auth instance
  static Drawer drawerComponent(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                  child: Text(
                'WELCOME TO E-Commerce',
                style: AppUtils.textBold(),
              )),
            ),
          ),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ProfileScreen();
            }));
          }, Icons.person_outline, 'Profile'),
          _listTileComponent(
              context, () {}, Icons.add_outlined, 'Add Products'),
          _listTileComponent(
              context, () {}, Icons.update_outlined, 'Update Products'),
          _listTileComponent(
              context, () {}, Icons.delete_outline, 'Delete Products'),
          _listTileComponent(
              context, () {}, Icons.view_agenda_outlined, 'View Products'),
          _listTileComponent(context, () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return LogInScreen();
            }), (route) => false);
          }, Icons.logout, 'LogOut'),
        ],
      ),
    );
  }

  static Widget _listTileComponent(
    BuildContext context,
    void Function()? onTap,
    IconData leadingIcon,
    String title,
  ) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(leadingIcon),
          title: Text(title),
          trailing: Icon(Icons.forward_outlined),
        ),
        Divider(),
      ],
    );
  }
}
