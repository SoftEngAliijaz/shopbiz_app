import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///assigning uid to userUID
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
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
            if (user['photoURL'] != null && user['displayName'] != null) {
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
}
