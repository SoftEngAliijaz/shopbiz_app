import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(AppConstants.splashScreenBgImg),
          ),
        ),
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///logo
                Container(
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        AssetImage('assets/images/e_commerce_logo.png'),
                  ),
                ),

                ///
                const CustomTextField(
                  textEditingController: null,
                  prefixIcon: Icons.abc,
                  hintText: 'Enter Product ID',
                  // validator: (v) {},
                ),
                const CustomTextField(
                  textEditingController: null,
                  prefixIcon: Icons.abc,
                  hintText: 'Enter Product Name',
                  // validator: (v) {},
                ),
                const CustomTextField(
                  textEditingController: null,
                  prefixIcon: Icons.abc,
                  hintText: 'Enter Project Description',
                  // validator: (v) {},
                ),
                const CustomTextField(
                  textEditingController: null,
                  prefixIcon: Icons.abc,
                  hintText: 'Enter Product Quantity',
                  // validator: (v) {},
                ),

                const CustomTextField(
                  textEditingController: null,
                  prefixIcon: Icons.abc,
                  hintText: 'Enter Project Description',
                  // validator: (v) {},
                ),
                CustomButton(
                  title: 'ADD PRODUCT',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
