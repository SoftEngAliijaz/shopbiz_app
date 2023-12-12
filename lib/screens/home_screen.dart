import 'package:flutter/material.dart';
import 'package:shopbiz_app/components/carousel_slider.dart';
import 'package:shopbiz_app/components/components.dart';
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
          style: AppConstants.textBold(),
        ),
      ),

      ///custom Drawer
      drawer: AppComponents.drawerComponent(),

      ///body
      body: Column(
        children: [
          ///Carousel Slider
          carouselSliderMethod(),

          ///Grid view & Listview
          Expanded(
            child: GridView.builder(
              itemCount: gridModel.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: gridModel[index].cardColor,
                  child: Center(child: Text(gridModel[index].title.toString())),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
