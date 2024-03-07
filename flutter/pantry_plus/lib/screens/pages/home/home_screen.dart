import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/home_controller.dart';
import 'package:pantry_plus/screens/pages/home/widgets/custom_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: const CustomBottomBar(),
            body: Stack(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: controller.pages[controller.selectedPage.value],
                ),
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
              ],
            ),
          );
        });
  }
}
