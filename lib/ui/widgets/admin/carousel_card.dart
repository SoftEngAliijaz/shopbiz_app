import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class CarouselCardWidget extends StatelessWidget {
  const CarouselCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.25,
      width: size.width * 0.95,
      decoration: BoxDecoration(color: AppColors.kWhiteColor),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: const Center(child: Text('Admin Carousel Slider Card')),
      ),
    );
  }
}
