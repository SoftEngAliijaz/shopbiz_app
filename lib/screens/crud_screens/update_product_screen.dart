import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Products'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final v = snapshot.data!.docs[index];
                TextEditingController nameC = TextEditingController();
                TextEditingController descriptionC = TextEditingController();
                TextEditingController priceC = TextEditingController();

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading:
                          CircleAvatar(child: Center(child: Text(v['id']))),
                      title: Text(v['name']),
                      subtitle: Text(v['description']),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Are You Sure?'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: nameC,
                                    decoration: InputDecoration(
                                      hintText: "Product Name: ${v['name']}",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: descriptionC,
                                    decoration: InputDecoration(
                                      hintText: "Desc: ${v['description']}",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: priceC,
                                    decoration: InputDecoration(
                                      hintText: "Price: ${v['price']}",
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("No"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(v.id)
                                        .update({
                                          'name': nameC.text,
                                          'description': descriptionC.text,
                                          'price': priceC.text,
                                        })
                                        .whenComplete(
                                            () => Navigator.pop(context))
                                        .then((value) => Fluttertoast.showToast(
                                            msg: 'Updated ${nameC.text}'));
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
