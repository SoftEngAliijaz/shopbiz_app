import 'package:flutter/material.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (c, i) {
          return Card(
            color: Colors.red,
            child: ListTile(
              title: Text('product title'),
              subtitle: Text('product subtitle'),
            ),
          );
        },
      ),
    );
  }
}
