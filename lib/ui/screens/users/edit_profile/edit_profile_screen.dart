import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameEditingController = TextEditingController();
    final TextEditingController emailEditingController =
        TextEditingController();
    final TextEditingController phoneNumberEditingController =
        TextEditingController();
    final TextEditingController addressEditingController =
        TextEditingController();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.kBlackColor,
              fontSize: size.width * 0.05,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          CircleAvatar(
            backgroundImage: const AssetImage('assets/logos/rider.jpg'),
            radius: size.width * 0.10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: size.width * 0.08,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kWhiteColor),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
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
          SizedBox(
            height: size.height * 0.06,
          ),
          CustomTextField(
            hintText: 'Name',
            textEditingController: nameEditingController,
          ),
          CustomTextField(
            hintText: 'Email Address',
            textEditingController: emailEditingController,
          ),
          CustomTextField(
            hintText: 'Mobile Number',
            textEditingController: phoneNumberEditingController,
          ),
          CustomTextField(
            hintText: 'Enter Address',
            textEditingController: addressEditingController,
          ),
          CustomButton(
            title: 'Update',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
