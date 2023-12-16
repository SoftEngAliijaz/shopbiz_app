import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/home/home_screen.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  final String? getId;
  final String? getName;
  final String? getDescription;
  final String? getPrice;

  const AddProductScreen({
    Key? key,
    this.getId,
    this.getName,
    this.getDescription,
    this.getPrice,
  }) : super(
          key: key,
        );

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ///controllers
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  ///globaly key
  var globalkey = GlobalKey<FormState>();

  ///add Products Function
  Future<void> addProducts() async {
    try {
      if (globalkey.currentState!.validate()) {
        await FirebaseFirestore.instance
            .collection('products')
            .doc()
            .set({
              'id': _idController.text,
              'name': _nameController.text,
              'description': _descriptionController.text,
              'price': _priceController.text,
            })
            .whenComplete(
                () => AppConstants.showToast('Products Added Successfully'))
            .whenComplete(
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return HomeScreen();
                  },
                ),
              ),
            );
      }
    } catch (e) {
      AppConstants.showToast(e.toString());
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Form(
              key: globalkey,
              child: SingleChildScrollView(
                child: Container(
                  height: size.height * 0.80,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                        CustomTextField(
                          textEditingController: _idController,
                          prefixIcon: Icons.abc,
                          hintText: 'Enter Product ID',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextField(
                          textEditingController: _nameController,
                          prefixIcon: Icons.abc,
                          hintText: 'Enter Product Name',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextField(
                          textEditingController: _descriptionController,
                          prefixIcon: Icons.abc,
                          hintText: 'Enter Product Description',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextField(
                          textEditingController: _priceController,
                          prefixIcon: Icons.abc,
                          hintText: 'Enter Product Price',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),

                        CustomButton(
                          title: 'Add Product',
                          onPressed: () async {
                            await addProducts();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
