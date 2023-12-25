import 'package:flutter/material.dart';

class ProductCartScreen extends StatelessWidget {
  const ProductCartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('ProductCartScreen'),
      ),
    );
  }
}
