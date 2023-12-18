import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/components/carousel_slider_component.dart';
import 'package:shopbiz_app/components/drawer_component.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/models/grid_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'E-Commerce',
          style: AppUtils.textBold(),
        ),
      ),

      ///custom Drawer
      drawer: Components.drawerComponent(context),

      ///body
      body: Column(
        children: [
          ///stream builder
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  var user = snapshot.data!;

                  if (snapshot.hasData) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            user['photoURL'].toString()),
                      ),
                      title: Text("Welcome ${user['displayName'].toString()}"),
                    );
                  } else {
                    return Center();
                  }
                }),
          ),

          ///Carousel Slider
          carouselSliderMethod(),

          ///Grid view & Listview
          GridView.builder(
            shrinkWrap: true,
            itemCount: gridModel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int index) {
              /// Use modulo to cycle through colors
              final colorValue = gridViewModelCardColors[
                  index % gridViewModelCardColors.length];

              ///assigned
              final value = gridModel[index].title.toString();

              ///inkwell
              return InkWell(
                onTap: () {
                  navigateToScreen(context, value);
                },
                child: Card(
                  color: colorValue,
                  child: Center(
                    child: Text(
                      ///showed
                      value,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
