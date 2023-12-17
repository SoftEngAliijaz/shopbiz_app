import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';

class AppComponents {
  ///firebase auth instance
  static FirebaseAuth auth = FirebaseAuth.instance;
  static Drawer drawerComponent() {
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
          _listTileComponent(() {}, Icons.person_outline, 'Profile'),
          _listTileComponent(() {}, Icons.add_outlined, 'Add Products'),
          _listTileComponent(() {}, Icons.update_outlined, 'Update Products'),
          _listTileComponent(() {}, Icons.delete_outline, 'Delete Products'),
          _listTileComponent(
              () {}, Icons.view_agenda_outlined, 'View Products'),
          _listTileComponent(() async {
            await auth.signOut();
          }, Icons.logout, 'LogOut'),
        ],
      ),
    );
  }

  static Widget _listTileComponent(
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
