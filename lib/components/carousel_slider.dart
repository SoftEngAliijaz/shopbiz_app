import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/models/carousel_slider_model.dart';

CarouselSlider carouselSliderMethod() {
  return CarouselSlider(
    items: carouselSliderModel.map((e) {
      return Card(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                e.imageUrl.toString(),
              ),
            ),
          ),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: double.infinity,
                  color: Colors.black38,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      e.title.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))),
        ),
      );
    }).toList(),
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 16 / 9,
      initialPage: 0,
    ),
  );
}
