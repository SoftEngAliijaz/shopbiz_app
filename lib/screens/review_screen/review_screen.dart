import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/widgets/custom_button.dart';
import 'package:shopbiz_app/widgets/custom_text_field.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController viewController = TextEditingController();
  bool isSaving = false;

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Review your place"),
            content: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Enter Location',
                    textEditingController: locationController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    textEditingController: viewController,
                    hintText: 'Enter Location',
                  ),
                ),
              ],
            )),
            actions: [
              CustomButton(
                  title: "SAVE",
                  onPressed: () {
                    saveReview();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  saveReview() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('reviews').add({
      'location': locationController.text,
      'views': viewController.text
    }).then((value) {
      setState(() {
        isSaving = false;
        Fluttertoast.showToast(msg: 'review uploaded successfully');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSaving == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  const Text(
                    "Recent Review by other",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('reviews')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Card(
                                elevation: 10,
                                // color: Colors.primaries[Random().nextInt(17)],
                                child: ListTile(
                                  title: Text(
                                    data['location'],
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  subtitle: Text(data['views']),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          showAlert(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
