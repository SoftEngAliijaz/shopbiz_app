import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
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
                  AppUtils.splashScreenBgImg,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(),
              title: Text('title'),
              subtitle: Text('subtitle'),
              trailing: Text('Price'),
            ),
          ],
        ),
      ),
    );
  }
}
