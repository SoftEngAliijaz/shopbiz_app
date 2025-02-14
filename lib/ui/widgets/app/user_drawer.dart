import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/screens/authentication/log_in_screen.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'user.email@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildTile(context, Icons.home_outlined, 'Home', () {}),
          _buildTile(context, Icons.person_outline, 'Profile', () {}),
          _buildTile(
              context, Icons.privacy_tip_outlined, 'Privacy Policy', () {}),
          _buildTile(context, Icons.warning_amber_outlined,
              'Terms & Conditions', () {}),
          _buildTile(
              context, Icons.rate_review_outlined, 'Rate our app', () {}),
          _buildTile(context, Icons.settings_outlined, 'Settings', () {}),
          Divider(),
          _buildTile(context, Icons.logout_outlined, 'Logout', () async {
            FirebaseAuth _auth = FirebaseAuth.instance;
            await _auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return LogInScreen();
            }));
          }),
        ],
      ),
    );
  }

  ListTile _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    void Function()? onTap,
  ) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}
