import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/screens/crud_screens/product_screens/product_detail_screens.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.none) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final v = snapshot.data!.docs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ProductDetailScreen();
                    }));
                  },
                  child: _productCard(v),
                );
              },
              separatorBuilder: (c, i) {
                return const Divider();
              },
            );
          } else {
            return const Center(
              child: Text('No Data Found...'),
            );
          }
        },
      ),
    );
  }

  Card _productCard(QueryDocumentSnapshot<Object?> v) {
    return Card(
      color: Colors.white,
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Image.network(
                  v['imageUrl'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Divider(),
            ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                  child: Center(
                child: Text(v['id'], overflow: TextOverflow.ellipsis),
              )),
              title: Text(v['name']),
              subtitle: Text(v['description']),
              trailing: Text("Price:${v['price']}"),
            ),
          ],
        ),
      ),
    );
  }
}