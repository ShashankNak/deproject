import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  final Offset start;
  final Offset firstStart;
  final Offset firstEnd;
  final Offset secondStart;
  final Offset secondEnd;
  final Offset end;

  MyClipper({
    required this.start,
    required this.firstStart,
    required this.firstEnd,
    required this.secondStart,
    required this.secondEnd,
    required this.end,
  });
  @override
  Path getClip(Size size) {
    // var firstStart = Offset(size.width / 5, size.height);
    // var firstEnd = Offset(size.width / 2.25, size.height / 1.1);
    // var secondStart = Offset(size.width / 1.2, size.height / 1.4);
    // var secondEnd = Offset(size.width, size.height / 1.2);
    return Path()
      ..lineTo(start.dx * size.width, start.dy * size.height)
      ..quadraticBezierTo(
        firstStart.dx * size.width,
        firstStart.dy * size.height,
        firstEnd.dx * size.width,
        firstEnd.dy * size.height,
      )
      ..quadraticBezierTo(
        secondStart.dx * size.width,
        secondStart.dy * size.height,
        secondEnd.dx * size.width,
        secondEnd.dy * size.height,
      )
      ..lineTo(end.dx * size.width, end.dy * size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
