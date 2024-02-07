import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom/clip_shadow_path.dart';
import 'custom/custom_clipper.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  double _containerHeight = Get.size.longestSide / 2.5;
  double _imagePosition = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increaseHeight() {
    setState(() {
      _containerHeight =
          Get.size.longestSide / 1.4; // Increase the height by 50 pixels
      //move the image to the left by 50 pixels
      _imagePosition = -50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipShadowPath(
          clipper: MyClipper(),
          shadow: const BoxShadow(
            color: Color.fromARGB(199, 158, 158, 158),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: 10,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _containerHeight,
            width: Get.size.width,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.secondary,
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: Alignment(_imagePosition, 0),
                  duration: const Duration(milliseconds: 500),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Get.size.width / 2)),
                    child: Image.asset(
                      'assets/images/profile.jpeg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: Get.size.longestSide / 3.4,
          left: Get.size.width / 1.2,
          child: FloatingActionButton.small(
            backgroundColor: Colors.teal.withOpacity(0.4),
            onPressed: _increaseHeight,
            child: const Icon(Icons.keyboard_double_arrow_down),
          ),
        ),
      ],
    );
  }
}
