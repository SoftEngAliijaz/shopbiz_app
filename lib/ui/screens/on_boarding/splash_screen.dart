import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _showButton = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const LogInScreen();
      }));
    });

    super.initState();
  }

  void _onFinishAnimation() {
    setState(() {
      _showButton = true;
    });
  }

  AnimatedTextKit _animatedText() {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'Welcome to Shopbiz Application',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(fontSize: 24.0),
          speed: const Duration(milliseconds: 50),
        ),
        TypewriterAnimatedText(
          'Fresh products at your doorstep!',
          textAlign: TextAlign.center,
          textStyle: TextStyle(fontSize: 24.0, color: AppColors.kBlackColor),
          speed: const Duration(milliseconds: 50),
        ),
        TypewriterAnimatedText(
          'Fast Delivery',
          textAlign: TextAlign.center,
          textStyle: TextStyle(fontSize: 24.0, color: AppColors.kBlackColor),
          speed: const Duration(milliseconds: 50),
        ),
        TypewriterAnimatedText(
          'Shop Anytime, Anywhere',
          textAlign: TextAlign.center,
          textStyle: TextStyle(fontSize: 24.0, color: AppColors.kBlackColor),
          speed: const Duration(milliseconds: 50),
        ),
        TypewriterAnimatedText(
          'Let\'s Get Started!',
          textAlign: TextAlign.center,
          textStyle: TextStyle(fontSize: 24.0, color: AppColors.kBlackColor),
          speed: const Duration(milliseconds: 50),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 500),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
      onFinished: _onFinishAnimation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final responsive = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Scaffold(
      body: responsive
          ? Container(
              decoration: BoxDecoration(color: AppColors.kWhiteColor),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withOpacity(0.4)),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logos/main_logo.png',
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10.0),
                      _animatedText(),
                      const SizedBox(height: 20.0),
                      Visibility(
                        visible: _showButton,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()));
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset('assets/logos/main_logo.png'),
                          ),
                          const SizedBox(height: 10.0),
                          _animatedText(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset('assets/logos/grocery_items_image.png',
                      fit: BoxFit.contain),
                ),
              ],
            ),
    );
  }
}
