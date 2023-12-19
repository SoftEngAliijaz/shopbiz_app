import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/screens/crud_screens/update_product_screen.dart';

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
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final v = snapshot.data!.docs[index];
                  return InkWell(
                    ///onlong press to update
                    onLongPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return UpdateProductScreen(
                          getId: v['id'],
                          getName: v['name'],
                          getDescription: v['description'],
                          getPrice: v['price'],
                        );
                      }));
                    },
                    onTap: () {
                      ///will navigate to products overview/details screen
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            child: Text(v['id']),
                          ),
                          title: Text(v['name']),
                          children: [
                            ListTile(
                              title: Text(
                                "Description: ${v['description']}",
                                textAlign: TextAlign.start,
                              ),
                              trailing: Text("Price: ${v['price']}"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text('No Data Found...'),
            );
          }
        },
      ),
    );
  }
}
/*
 Container(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Image.network(
                                AppUtils.splashScreenBgImg,
                                fit: BoxFit.fitWidth,
                              )),
                              ListTile(
                                title: Text('Product Name'),
                                subtitle: Text('Product Description'),
                                trailing: Text('Price: price'),
                              ),
                            ],
                          ),
                        ),O
*/
