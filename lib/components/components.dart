import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';

class AppComponents {
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
                style: AppConstants.textBold(),
              )),
            ),
          ),
          ListTile(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
          _cardTileForDrawer(),
          _cardTileForDrawer(),
          _cardTileForDrawer(),
          _cardTileForDrawer(),
        ],
      ),
    );
  }

  static Card _cardTileForDrawer() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.abc),
        title: Text(
          'this is title',
          style: AppConstants.textBold(),
        ),
        subtitle: Text(
          'this is subtitle',
          style: AppConstants.textBold(),
        ),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
