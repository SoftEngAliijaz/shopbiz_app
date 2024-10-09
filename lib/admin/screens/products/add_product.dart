import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/data/models/product_model.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isOnSale = false;
  bool isOnDiscount = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  void addProduct() async {
    const String colllectionName = 'admin_products';
    if (_formKey.currentState!.validate()) {
      final String productId = const Uuid().v4();

      ProductModel newProduct = ProductModel(
        id: productId,
        name: nameController.text,
        description: descriptionController.text,
        quantity: int.parse(quantityController.text),
        brand: brandController.text,
        condition: conditionController.text,
        category: categoryController.text,
        isOnSale: isOnSale,
        isDiscountAvailable: isOnDiscount,
        price: double.parse(priceController.text),
      );

      try {
        await _firestore
            .collection(colllectionName)
            .doc(productId)
            .set(newProduct.toJson());
        Fluttertoast.showToast(msg: 'Products Added Successfully!');
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error adding product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.arrow_forward_outlined),
                    title: Text(
                      'Add Products',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.production_quantity_limits_outlined,
                    hintText: 'Please Enter Your Product Name',
                    textEditingController: nameController,
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.description_outlined,
                    hintText: 'Please Enter Your Product Description',
                    textEditingController: descriptionController,
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.numbers_outlined,
                    hintText: 'Please Enter Your Product Quantity',
                    textEditingController: quantityController,
                    keyboardType: TextInputType.number,
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.branding_watermark_outlined,
                    hintText: 'Please Enter Your Product Brand',
                    textEditingController: brandController,
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.auto_fix_high_outlined,
                    hintText: 'Please Enter Your Product Condition',
                    textEditingController: conditionController,
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.category_outlined,
                    hintText: 'Please Enter Your Product Category',
                    textEditingController: categoryController,
                  ),
                  CheckboxListTile(
                    title: const Text('Is Product on SALE?'),
                    value: isOnSale,
                    onChanged: (v) {
                      setState(() {
                        isOnSale = v ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Is Product on Discount?'),
                    value: isOnDiscount,
                    onChanged: (v) {
                      setState(() {
                        isOnDiscount = v ?? false;
                      });
                    },
                  ),
                  CustomTextField(
                    validator: (v) => v == null || v.isEmpty
                        ? "This Field Cannot be Empty"
                        : null,
                    prefixIcon: Icons.price_change_outlined,
                    hintText: 'Please Enter Your Product Price',
                    textEditingController: priceController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    title: 'Add/Save Product',
                    onPressed: addProduct,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
