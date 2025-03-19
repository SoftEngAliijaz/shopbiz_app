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
      appBar: AppBar(
        title: const Text('Update Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Product Details',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                  prefixIcon: Icons.numbers_outlined,
                  hintText: 'ID',
                  textEditingController: idController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.production_quantity_limits_outlined,
                  hintText: 'Product Name',
                  textEditingController: nameController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.description_outlined,
                  hintText: 'Product Description',
                  textEditingController: descriptionController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.numbers_outlined,
                  hintText: 'Product Quantity',
                  textEditingController: quantityController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.branding_watermark_outlined,
                  hintText: 'Product Brand',
                  textEditingController: brandController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.auto_fix_high_outlined,
                  hintText: 'Product Condition',
                  textEditingController: conditionController),
              const SizedBox(height: 10.0),
              CustomTextField(
                  prefixIcon: Icons.category_outlined,
                  hintText: 'Product Category',
                  textEditingController: categoryController),
              const SizedBox(height: 10.0),
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
                  hintText: 'Product Price',
                  textEditingController: priceController),
              const SizedBox(height: 20.0),
              Center(
                child: CustomButton(
                  title: 'Update/Save Product',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
