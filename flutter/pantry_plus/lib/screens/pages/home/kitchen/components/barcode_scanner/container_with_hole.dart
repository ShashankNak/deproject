import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContainerWithHole extends StatefulWidget {
  const ContainerWithHole({super.key});

  @override
  State<ContainerWithHole> createState() => _ContainerWithHoleState();
}

class _ContainerWithHoleState extends State<ContainerWithHole>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
            begin: Get.size.height / 2.3, end: Get.size.height / 2.3 + 100)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcOut),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4, bottom: 4),
                    height: Get.size.height / 4,
                    width: Get.size.width / 1.2,
                    decoration: BoxDecoration(
                      color: Colors
                          .black, // Color does not matter but should not be transparent
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: _animation.value,
          left: Get.size.width / 13,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            width: Get.size.width / 1.2,
            height: 2,
          ),
        ),
      ],
    );
  }
}
