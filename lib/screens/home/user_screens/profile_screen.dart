import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          if (snapshot.hasData) {
            // Assuming there is only one user document, use first
            var user = snapshot.data!;
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(user['photoURL'].toString()),
                ),
                Text(user['displayName'].toString()),
              ],
            );
          } else {
            // or some loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
