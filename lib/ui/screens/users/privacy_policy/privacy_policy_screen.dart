import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

//
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        // foregroundColor: AppColors.kWhiteColor,
        title: const Text('Privacy Policy'),

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: AppColors.kWhiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Last Update : 17/8/2024',
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    const Text(
                        'Shopbiz  is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our mobile grocery app.'),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04),
                      ),
                    ),
                    const Text(textAlign: TextAlign.left, '''

We may collect personal information such as your name, email address, phone number, delivery address, and payment details when you register or place an order. We may also collect location data (with your permission) to offer location-based services, such as delivery tracking, and information about your device and how you interact with the app.

We use this information to provide services such as order processing and delivery, improve your experience, send you updates and promotions, and ensure app security. Your information may be shared with third-party service providers (e.g., payment processors, delivery services) but will not be sold or traded to third parties. We may also disclose your information if required by law.

You can control your personal information through app settings, such as modifying your account, opting out of notifications, or enabling/disabling location services. We implement security measures to protect your data; however, no method of electronic transmission is completely secure, so we cannot guarantee absolute protection.

Our app is not intended for children under the age of 13, and we do not knowingly collect information from them. If we become aware that a child under 13 has provided us with personal information, we will take steps to remove that data.

We may update this Privacy Policy periodically. Any changes will be posted in the app. We encourage you to review the policy regularly to stay informed about how we handle your information.

If you have any questions or concerns about this Privacy Policy, please contact us at:

Email: grocerystore@gmail.com
Address: Lahore, Pakistan
            
            - Email: grocerystore@gmail.com  
            - Address: Lahore Pakistan 
            ''')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
