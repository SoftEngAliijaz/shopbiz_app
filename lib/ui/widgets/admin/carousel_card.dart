import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class CarouselCardWidget extends StatelessWidget {
  final String title;
  final String image;

  const CarouselCardWidget({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: size.height * 0.25,
        width: size.width * 0.95,
        decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(image), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: size.width * 0.95,
              decoration: BoxDecoration(
                color: AppColors.kBlackColor.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
