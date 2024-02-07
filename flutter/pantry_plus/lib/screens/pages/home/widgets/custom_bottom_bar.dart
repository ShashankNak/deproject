import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Get.size.shortestSide / 25),
              topRight: Radius.circular(Get.size.shortestSide / 25)),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: Get.size.shortestSide / 25,
            vertical: Get.size.shortestSide / 20),
        child: GNav(
            onTabChange: (value) {
              controller.changeScreen(value);
            },
            selectedIndex: controller.selectedPage.value,
            backgroundColor: Get.theme.colorScheme.primary,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            activeColor: Get.theme.colorScheme.onPrimary,
            color: Colors.white,
            padding: const EdgeInsets.all(16), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.kitchen,
                text: 'Pantry',
              ),
              GButton(
                icon: LineIcons.cookie,
                text: 'Recipe',
              ),
              GButton(
                icon: LineIcons.calendar,
                text: 'Planner',
              ),
              GButton(
                icon: Icons.restaurant_menu_rounded,
                text: 'Dining',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              )
            ]),
      ),
    );
  }
}
