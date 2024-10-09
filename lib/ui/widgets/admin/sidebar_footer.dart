import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminSideBarFooterWidget extends StatefulWidget {
  const AdminSideBarFooterWidget({super.key});

  @override
  State<AdminSideBarFooterWidget> createState() =>
      _AdminSideBarFooterWidgetState();
}

class _AdminSideBarFooterWidgetState extends State<AdminSideBarFooterWidget> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kPrimaryColor),
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              _launchUrl('https://www.facebook.com/');
            },
            child: CircleAvatar(
              child: SvgPicture.asset(
                'assets/social_logos/facebook_logo.svg',
                height: 25.0,
                width: 25.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl('https://www.github.com/');
            },
            child: CircleAvatar(
              child: SvgPicture.asset(
                'assets/social_logos/github_logo.svg',
                height: 25.0,
                width: 25.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl('https://www.instagram.com/');
            },
            child: CircleAvatar(
              child: SvgPicture.asset(
                'assets/social_logos/instagram_logo.svg',
                height: 25.0,
                width: 25.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchUrl('https://www.linkedin.com/in/');
            },
            child: CircleAvatar(
              child: SvgPicture.asset(
                'assets/social_logos/linkedin_logo.svg',
                height: 25.0,
                width: 25.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
