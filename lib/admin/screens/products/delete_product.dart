import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Products'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text('Product ${index + 1}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever, color: Colors.red),
                  onPressed: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
