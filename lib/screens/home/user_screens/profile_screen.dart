import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopbiz_app/constants/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            // Assuming
            var user = snapshot.data!;

            // Check if required fields are not null
            if (user['photoURL'] != null || user['displayName'] != null) {
              return Column(
                children: [
                  SizedBox(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: CachedNetworkImageProvider(
                              user['photoURL'] ?? AppUtils.splashScreenBgImg),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    _showModalBottomSheetSuggestions(context);
                                  },
                                  icon: const Icon(
                                    Icons.add_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                      child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text(user['displayName'].toString()),
                  )),
                  Card(
                      child: ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text(user['email'].toString()),
                  )),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Theme.of(context).cardColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              );
            } else {
              // Handle case where required fields are null
              return const Center(child: Text('User data is incomplete.'));
            }
          } else {
            // Handle case where snapshot does not have data
            return const Center(child: Text('No user data found.'));
          }
        },
      ),
    );
  }

  void _showModalBottomSheetSuggestions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: new Icon(Icons.camera_alt_outlined),
                  title: new Text('Pick From Camera'),
                  onTap: () => {_pickFromCamera()},
                ),
                new ListTile(
                  leading: new Icon(Icons.image_search_outlined),
                  title: new Text('Pick From Gallery'),
                  onTap: () => {_pickFromGallery()},
                ),
              ],
            ),
          );
        });
  }

  _pickFromCamera() {
    return Fluttertoast.showToast(msg: 'Picking Image from Camera');
  }

  _pickFromGallery() {
    return Fluttertoast.showToast(msg: 'Picking Image from Gallery');
  }
}
