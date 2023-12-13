import 'dart:async';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/screens/initial_screen/user_way_entry_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  ///
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return UserWayEntryScreen();
      }));
    });

    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(AppConstants.splashScreenBgImg),
          ),
        ),
        child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///logo
                Container(
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        AssetImage('assets/images/e_commerce_logo.png'),
                  ),
                ),
                SizedBox(height: 20),

                ///title
                Text(
                  'WELCOME TO SHOPBIZ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    totalRepeatCount: 5,
                    animatedTexts: [
                      TyperAnimatedText('Buy Anything you want',
                          textAlign: TextAlign.center,
                          textStyle: AppConstants.animationStyle()),
                      TyperAnimatedText('Just in 1 click',
                          textAlign: TextAlign.center,
                          textStyle: AppConstants.animationStyle()),
                      TyperAnimatedText(
                          'We Deliver Your products at your door step',
                          textAlign: TextAlign.center,
                          textStyle: AppConstants.animationStyle()),
                    ]),

                SizedBox(height: 20),

                ///progress bar
                Container(child: AppConstants.customProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
