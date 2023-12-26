import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/crud/add_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/crud/delete_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/crud/view_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/crud/update_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/product_screens/product_cart_screen.dart';
import 'package:shopbiz_app/screens/review_screen/review_screen.dart';
import 'package:shopbiz_app/screens/user_screens/profile_screen.dart';

class Components {
  ///firebase auth instance
// Create a drawer component for navigation
  static Drawer drawerComponent(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Drawer header with the Shopbiz logo and welcome message
          DrawerHeader(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/e_commerce_logo.png'),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        'WELCOME TO Shopbiz',
                        overflow: TextOverflow.ellipsis,
                        style: AppUtils.textBold(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigate to the ProfileScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ProfileScreen();
            }));
          }, Icons.person_outline, 'Profile'),

          // List tiles for various navigation options
          // Navigate to the AddProductScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const AddProductScreen();
            }));
          }, Icons.add_outlined, 'Add Products'),

          // Navigate to the UpdateProductScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const UpdateProductScreen();
            }));
          }, Icons.update_outlined, 'Update Products'),

          // Navigate to the DeleteProductScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const DeleteProductScreen();
            }));
          }, Icons.delete_outline, 'Delete Products'),

          // Navigate to the ViewProductScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ViewProductScreen();
            }));
          }, Icons.view_agenda_outlined, 'View Products'),

          // Navigate to the ProductCartScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return ProductCartScreen();
            }));
          }, Icons.shopping_bag_outlined, 'Cart'),

          // Navigate to the ReviewScreen
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ReviewScreen();
            }));
          }, Icons.reviews_outlined, 'Review/Feedback'),

          // Sign out user and navigate to the LogInScreen
          _listTileComponent(context, () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return const LogInScreen();
            }), (route) => false);
          }, Icons.logout, 'LogOut'),
        ],
      ),
    );
  }

// Create a common list tile component used in the drawer
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
