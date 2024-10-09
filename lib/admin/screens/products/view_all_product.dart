import 'package:flutter/material.dart';

class ViewAllProductScreen extends StatelessWidget {
  const ViewAllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // final TextEditingController idController = TextEditingController();
    // final TextEditingController nameController = TextEditingController();
    // final TextEditingController descriptionController = TextEditingController();
    // final TextEditingController quantityController = TextEditingController();
    // final TextEditingController brandController = TextEditingController();
    // final TextEditingController conditionController = TextEditingController();
    // final TextEditingController categoryController = TextEditingController();
    // final TextEditingController isOnSaleController = TextEditingController();
    // final TextEditingController isDiscountAvailableController =
    //     TextEditingController();
    // final TextEditingController priceController = TextEditingController();

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return const Card(child: Text('Show Data Here...'));
          },
        ),
      ),
    );
  }
}
