import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/credientals/login_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/add_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/delete_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/product_screens/product_cart_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/product_screens/product_fav_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/update_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/view_product_screen.dart';
import 'package:shopbiz_app/screens/review_screen/review_screen.dart';
import 'package:shopbiz_app/screens/user_screens/profile_screen.dart';

class Components {
  ///firebase auth instance
  static Drawer drawerComponent(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
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
                    )),
                  ],
                ),
              ),
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
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ProductFavScreen();
            }));
          }, Icons.favorite_outline, 'Favirote'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ProductCartScreen();
            }));
          }, Icons.shopping_bag_outlined, 'Cart'),
          _listTileComponent(context, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const ReviewScreen();
            }));
          }, Icons.reviews_outlined, 'Review/Feedback'),
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
