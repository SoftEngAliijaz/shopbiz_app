import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? getId;
  final String? getTitle;
  final String? getDescription;
  final String? getPrice;
  final String? getImage;

  const ProductDetailScreen({
    Key? key,
    this.getId,
    this.getTitle,
    this.getDescription,
    this.getPrice,
    this.getImage,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.getTitle!),
      ),
      bottomNavigationBar: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  backgroundColor: Colors.blue,
                  iconColor: Colors.red,
                ),
                onPressed: () {},
                icon: Icon(Icons.favorite),
                label: Text(
                  'Add to Favitore',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  backgroundColor: Colors.blue,
                  iconColor: Colors.red,
                ),
                onPressed: () {},
                icon: Icon(Icons.shopping_bag),
                label: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Center(
                child: Image.network(
                  widget.getImage!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text(widget.getId!),
              ),
              title: Text(widget.getTitle!),
              subtitle: Text(widget.getDescription!),
              trailing: Text(widget.getPrice!),
            ),
          ],
        ),
      ),
    );
  }
}
