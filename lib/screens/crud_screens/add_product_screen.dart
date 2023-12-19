import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        await FirebaseFirestore.instance.collection('products').doc().set({
          'id': _idController.text,
          'name': _nameController.text,
          'description': _descriptionController.text,
          'price': _priceController.text,
        }).then((_) {
          Fluttertoast.showToast(msg: 'Product Added Successfully');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }).catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
              child: Container(
                height: size.height * 0.90,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
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
                        SizedBox(height: 10),

                        ///
                        CustomTextField(
                          textEditingController: _idController,
                          prefixIcon: Icons.numbers_outlined,
                          hintText: 'Enter Product ID',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: _nameController,
                          prefixIcon: Icons.production_quantity_limits_outlined,
                          hintText: 'Enter Product Name',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),

                        CustomTextField(
                          textEditingController: _descriptionController,
                          prefixIcon: Icons.production_quantity_limits_outlined,
                          hintText: 'Enter Product Description',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),

                        CustomTextField(
                          textEditingController: _priceController,
                          prefixIcon: Icons.production_quantity_limits_outlined,
                          hintText: 'Enter Product Price',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 10),

                        ///Add Section to pick and upload images.
                        Container(
                          height: 200,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _showModalBottomSheetSuggestions();
                            },
                            icon: const Icon(Icons.image_outlined),
                          ),
                        ),

                        SizedBox(height: 10),

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

  void _showModalBottomSheetSuggestions() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: new Icon(Icons.camera_alt_outlined),
                  title: new Text('Pick From Camera'),
                  onTap: () => {_pickFromCamera()},
                ),
                new ListTile(
                  leading: new Icon(Icons.image_search_outlined),
                  title: new Text('Pick From Gallery'),
                  onTap: () => {_pickFromGallery()},
                ),
              ],
            ),
          );
        });
  }

  _pickFromCamera() {
    return Fluttertoast.showToast(msg: 'Picking Image from Camera');
  }

  _pickFromGallery() {
    return Fluttertoast.showToast(msg: 'Picking Image from Gallery');
  }
}
