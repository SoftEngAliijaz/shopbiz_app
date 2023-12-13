import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/constants/constants.dart';
import 'package:shopbiz_app/credientals/login_screen.dart';
import 'package:shopbiz_app/credientals/signup_screen.dart';

class UserWayEntryScreen extends StatelessWidget {
  const UserWayEntryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
      child: Container(
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

              ///
              SizedBox(height: 20),

              ///
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: AppConstants.animationStyle(),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Shopbiz',
                          textStyle: AppConstants.animationStyle()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              ///
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      shape: StadiumBorder(),
                      color: Colors.blue,
                      child: Center(child: Text('LOGIN')),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (_) {
                          return LogInScreen();
                        }), (route) => false);
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      shape: StadiumBorder(),
                      color: Colors.red,
                      child: Center(child: Text('SIGNUP')),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (_) {
                          return SingUpScreen();
                        }), (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
