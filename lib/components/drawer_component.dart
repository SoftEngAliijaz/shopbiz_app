import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/add_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/delete_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/update_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/view_product_screen.dart';
import 'package:shopbiz_app/screens/home/user_screens/profile_screen.dart';

class Components {
  ///firebase auth instance
  static Drawer drawerComponent(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0.0),
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
              return const ProfileScreen();
            }));
          }, Icons.person_outline, 'Profile'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const AddProductScreen();
            }));
          }, Icons.add_outlined, 'Add Products'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const UpdateProductScreen();
            }));
          }, Icons.update_outlined, 'Update Products'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const DeleteProductScreen();
            }));
          }, Icons.delete_outline, 'Delete Products'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ViewProductScreen();
            }));
          }, Icons.view_agenda_outlined, 'View Products'),
          _listTileComponent(context, () async {
            ///signout
            await FirebaseAuth.instance.signOut();

            /// ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return const LogInScreen();
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
          trailing: const Icon(Icons.forward_outlined),
        ),
        const Divider(),
      ],
    );
  }
}
