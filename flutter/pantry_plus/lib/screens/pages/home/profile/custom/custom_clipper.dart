import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height / 1.1);
    var secondStart = Offset(size.width / 1.2, size.height / 1.4);
    var secondEnd = Offset(size.width, size.height / 1.2);
    return Path()
      ..lineTo(0, size.height / 1.1)
      ..quadraticBezierTo(
        firstStart.dx,
        firstStart.dy,
        firstEnd.dx,
        firstEnd.dy,
      )
      ..quadraticBezierTo(
        secondStart.dx,
        secondStart.dy,
        secondEnd.dx,
        secondEnd.dy,
      )
      ..lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
