import 'package:flutter/material.dart';

class AuthClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();

    path.lineTo(0.05 * w, 0);
    path.lineTo(0.1 * w, 0.1 * h);
    path.lineTo(0.05 * w, 0.1 * h);
    path.lineTo(0.05 * w, 0.9 * h);
    path.lineTo(0.1 * w, 0.9 * h);
    path.lineTo(0.05 * w, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
