import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/app/list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width * 0.99,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.07),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kWhiteColor,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.01,
                          left: size.width * 0.05,
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              const AssetImage('assets/logos/rider.jpg'),
                          radius: size.width * 0.10,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: size.width * 0.08,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.kWhiteColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                color: AppColors.kPrimaryColor,
                              ),
                              child: IconButton(
                                color: AppColors.kWhiteColor,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alex Smith',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhiteColor,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            Text(
                              'alexsmith@gmail.com',
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomListTile(
              title: 'Edit Profile ',
              leadingIcon: Icons.edit_outlined,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            const CustomListTile(
              title: 'Change Password ',
              leadingIcon: Icons.lock_outline,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            const CustomListTile(
              title: 'Payment Method  ',
              leadingIcon: Icons.payment_outlined,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            const CustomListTile(
              title: 'My Orders ',
              leadingIcon: Icons.crop_square_outlined,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            const CustomListTile(
              title: 'Privacy Policy ',
              leadingIcon: Icons.shield_outlined,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            const CustomListTile(
              title: 'Terms & Conditions  ',
              leadingIcon: Icons.developer_board_outlined,
              trailingIcon: Icons.arrow_forward_outlined,
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.99,
              height: MediaQuery.of(context).size.height * 0.07,
              child: MaterialButton(
                color: AppColors.kPrimaryColor,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: AppColors.kWhiteColor,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout,
                        size: 20,
                      ),
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
