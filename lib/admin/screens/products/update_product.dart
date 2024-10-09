import 'package:flutter/material.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController brandController = TextEditingController();
    final TextEditingController conditionController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    bool isOnSale = false;
    bool isOnDiscount = false;
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.arrow_forward_outlined),
                title: Text(
                  'Update Products',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                  prefixIcon: Icons.numbers_outlined,
                  hintText: 'ID',
                  textEditingController: idController),
              CustomTextField(
                  prefixIcon: Icons.production_quantity_limits_outlined,
                  hintText: 'Please Enter Your Product Name',
                  textEditingController: nameController),
              CustomTextField(
                  prefixIcon: Icons.description_outlined,
                  hintText: 'Please Enter Your Product Description',
                  textEditingController: descriptionController),
              CustomTextField(
                  prefixIcon: Icons.numbers_outlined,
                  hintText: 'Please Enter Your Product Quantity',
                  textEditingController: quantityController),
              CustomTextField(
                  prefixIcon: Icons.branding_watermark_outlined,
                  hintText: 'Please Enter Your Product Brand',
                  textEditingController: brandController),
              CustomTextField(
                  prefixIcon: Icons.auto_fix_high_outlined,
                  hintText: 'Please Enter Your Product Condition',
                  textEditingController: conditionController),
              CustomTextField(
                  prefixIcon: Icons.category_outlined,
                  hintText: 'Please Enter Your Product Category',
                  textEditingController: categoryController),
              CheckboxListTile(
                  title: const Text('Is Product on SALE?'),
                  value: isOnSale,
                  onChanged: (v) {
                    setState(() {
                      isOnSale = !isOnSale;
                    });
                  }),
              CheckboxListTile(
                  title: const Text('Is Product on Discount?'),
                  value: isOnDiscount,
                  onChanged: (v) {
                    setState(() {
                      isOnDiscount = !isOnDiscount;
                    });
                  }),
              CustomTextField(
                  prefixIcon: Icons.price_change_outlined,
                  hintText: 'Please Enter Your Product Price',
                  textEditingController: priceController),
              const SizedBox(height: 20.0),
              CustomButton(
                title: 'Update/Save Product',
                onPressed: () {},
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
