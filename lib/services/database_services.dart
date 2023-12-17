import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
  ///add product function
  static Future<void> addProduct(
    String id,
    String name,
    String description,
    String price,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc().set({
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  ///update product function
  static Future<void> updateProduct(
    String productId,
    String id,
    String name,
    String description,
    String price,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  ///delete product function
  static Future<void> deleteProduct(
    String productId,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
