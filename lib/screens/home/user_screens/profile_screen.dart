import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // Assuming there is only one user document, use first
            var user = snapshot.data!.docs.first;
            return Column(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    user['photoURL'],
                  ),
                ),
                Text(user['displayName'].toString()),
                // Add other widgets as needed
              ],
            );
          } else {
            return CircularProgressIndicator(); // or some loading indicator
          }
        },
      ),
    );
  }

  // Container _profilePicture(QueryDocumentSnapshot<Object?> value) {
  //   return Container(
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: CircleAvatar(
  //           radius: 100,
  //           backgroundImage: CachedNetworkImageProvider(
  //             value['photoURL'].toString(),
  //           ),
  //           child: Align(
  //             alignment: Alignment.bottomRight,
  //             child: CircleAvatar(
  //               child: IconButton(
  //                 onPressed: () {},
  //                 icon: const Icon(Icons.add_outlined),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _listTile(
  //   IconData leadingIcon,
  //   String title,
  // ) {
  //   return SizedBox(
  //     child: Card(
  //         child: ListTile(
  //       leading: Icon(leadingIcon),
  //       title: Text(title),
  //     )),
  //   );
  // }
}

/*
       SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ///circle avatar used for profile image
              _profilePicture(size),

              ///listtile to show informations
              _listTile(Icons.person_outline, "Name",
                  FirebaseAuth.instance.currentUser!.displayName ?? "User"),
              _listTile(Icons.email_outlined, "Email",
                  FirebaseAuth.instance.currentUser!.email.toString()),
              _listTile(Icons.phone_outlined, "Phone",
                  FirebaseAuth.instance.currentUser!.phoneNumber ?? "N/A"),

              ///button
              MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: StadiumBorder(side: BorderSide.none),
                onPressed: () {},
                child: Center(child: Text('SAVE')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _profilePicture(Size size) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: size.height * 0.250,
      width: size.width,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL ??
                AppUtils.splashScreenBgImg),
      ),
    );
  }

  Widget _listTile(
    IconData leadingIcon,
    String title,
    String subtitle,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

       */
