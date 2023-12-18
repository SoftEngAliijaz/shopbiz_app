import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/screens/home/home_screen.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class UpdateProductScreen extends StatefulWidget {
  final String? getId;
  final String? getName;
  final String? getDescription;
  final String? getPrice;

  const UpdateProductScreen({
    Key? key,
    this.getId,
    this.getName,
    this.getDescription,
    this.getPrice,
  }) : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  ///controllers
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  ///globaly key
  var globalkey = GlobalKey<FormState>();

  ///add Products Function
  Future<void> updateProducts() async {}

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
        title: const Text('Update Product'),
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
                child: SizedBox(
                  height: size.height * 0.80,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///logo
                        const SizedBox(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage('assets/images/e_commerce_logo.png'),
                          ),
                        ),

                        ///
                        CustomTextField(
                          textEditingController: _idController,
                          prefixIcon: Icons.abc,
                          hintText: widget.getId,
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
                          hintText: widget.getName,
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
                          hintText: widget.getDescription,
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
                          hintText: widget.getPrice,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field Should not be Empty';
                            } else {
                              return null;
                            }
                          },
                        ),

                        CustomButton(
                          title: 'Update Product',
                          onPressed: () async {
                            try {
                              if (globalkey.currentState!.validate()) {
                                await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(widget.getId)
                                    .update({
                                  'id': widget.getId,
                                  'name': widget.getName,
                                  'description': widget.getDescription,
                                  'price': widget.getPrice,
                                }).then((_) {
                                  Fluttertoast.showToast(
                                      msg: 'Product Updated Successfully');
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
