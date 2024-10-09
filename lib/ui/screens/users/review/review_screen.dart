import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/app/tip_div.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Rider Review'), centerTitle: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset('assets/logos/rider.jpg',
                height: size.height * 0.450,
                width: size.width,
                fit: BoxFit.fitHeight),

            const SizedBox(height: 10.0),

            Text(
              'Stylish Queen',
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            // for spacing
            SizedBox(height: size.height * 0.01),
            Text(
              'Hotel Manager',
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: AppColors.kGreyColor,
              ),
            ),
            // for spacing
            SizedBox(height: size.height * 0.04),
            Text(
              'Please Rate Delivery Service ',
              style: TextStyle(fontSize: size.width * 0.06),
            ),
            SizedBox(height: size.height * 0.02),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                      child: Icon(Icons.star,
                          size: size.width * 0.06,
                          color: AppColors.kPrimaryColor)),
                  Expanded(
                      child: Icon(Icons.star,
                          size: size.width * 0.06,
                          color: AppColors.kPrimaryColor)),
                  Expanded(
                      child: Icon(Icons.star,
                          size: size.width * 0.06,
                          color: AppColors.kPrimaryColor)),
                  Expanded(
                      child: Icon(Icons.star,
                          size: size.width * 0.06,
                          color: AppColors.kPrimaryColor)),
                  Expanded(
                      child: Icon(Icons.star,
                          size: size.width * 0.06,
                          color: AppColors.kPrimaryColor)),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            SizedBox(height: 10.0),

            const ListTile(
                title: Text('Add Tips',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0))),
            SizedBox(height: 10.0),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TipDiv(title: 'Add Tip', isTip: true),
                    TipDiv(title: 'Rs. 100', isTip: false),
                    TipDiv(title: 'Rs. 200', isTip: false),
                    TipDiv(title: 'Rs. 300', isTip: false),
                    TipDiv(title: 'Rs. 400', isTip: false),
                    TipDiv(title: 'Rs. 500', isTip: false),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),

            const SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextField(
                  prefixIcon: Icons.comment_outlined,
                  hintText: 'Please enter your comments...',
                ),
              ),
            ),
            SizedBox(height: 10.0),

            CustomButton(title: 'Submit', onPressed: () {}),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
