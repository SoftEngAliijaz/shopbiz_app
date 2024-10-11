import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/core/constants/social_icons.dart';
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

  Widget _buildIcon(SocialIcon icon) {
    return InkWell(
      onTap: () => _launchUrl(icon.url),
      child: CircleAvatar(
        child: SvgPicture.asset(
          icon.asset,
          height: 25.0,
          width: 25.0,
          fit: BoxFit.contain,
        ),
      ),
    );
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
          _buildIcon(SocialIcon.facebook),
          _buildIcon(SocialIcon.github),
          _buildIcon(SocialIcon.instagram),
          _buildIcon(SocialIcon.linkedin),
        ],
      ),
    );
  }
}
