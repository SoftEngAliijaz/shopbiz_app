import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ///global image picker
  File? _pickedImage;

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
                  SizedBox(height: 10),
                  // SizedBox(
                  //   child: Card(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: CircleAvatar(
                  //         radius: 100,
                  //         backgroundImage: CachedNetworkImageProvider(
                  //             user['photoURL'] ?? AppUtils.splashScreenBgImg),
                  //         child: Align(
                  //           alignment: Alignment.bottomRight,
                  //           child: CircleAvatar(
                  //             backgroundColor: Theme.of(context).primaryColor,
                  //             child: Center(
                  //               child: IconButton(
                  //                 onPressed: () {
                  //                   _showModalBottomSheetSuggestions(context);
                  //                 },
                  //                 icon: const Icon(
                  //                   Icons.add_outlined,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  ///profile image
                  SizedBox(
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipOval(
                        child: Container(
                          child: _pickedImage != null
                              ? Image.file(
                                  _pickedImage!,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                )
                              : TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.photo_album),
                                  label: const Text('Pick Image'),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ///profile cards
                  _profileCard(
                      Icons.person_outline, user['displayName'].toString()),
                  SizedBox(height: 10),

                  _profileCard(Icons.email_outlined, user['email'].toString()),

                  ///save button
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

  Card _profileCard(
    IconData leadingIcon,
    String title,
  ) {
    return Card(
        child: ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
    ));
  }

  void _showModalBottomSheetSuggestions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('Pick From Camera'),
                  onTap: () => {_pickFromCamera()},
                ),
                ListTile(
                  leading: const Icon(Icons.image_search_outlined),
                  title: const Text('Pick From Gallery'),
                  onTap: () => {_pickFromGallery()},
                ),
              ],
            ),
          );
        });
  }

  Future<void> _pickFromCamera() async {
    Navigator.pop(context);
    try {
      final XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        setState(() {
          _pickedImage = File(selectedImage.path);
        });
        Fluttertoast.showToast(msg: 'Image Selected');
      } else {
        Fluttertoast.showToast(msg: 'Image Not Selected');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _pickFromGallery() async {
    Navigator.pop(context);
    try {
      final XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        setState(() {
          _pickedImage = File(selectedImage.path);
        });
        Fluttertoast.showToast(msg: 'Image Selected');
      } else {
        Fluttertoast.showToast(msg: 'Image Not Selected');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
