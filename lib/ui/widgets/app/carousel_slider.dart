import 'package:flutter/material.dart';
import 'package:shopbiz_app/data/models/ui_models/carousel_model.dart';
import 'package:shopbiz_app/ui/widgets/admin/carousel_card.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...carouselSliderModel.map((v) {
            return CarouselCardWidget(
              title: '${v.title}',
              image: '${v.imageUrl}',
            );
          }).toList()
        ],
      ),
    );
  }
}
