import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/start_screen/start_screen.dart';

import '../../../../controller/home/kitchen/kitchen_controller.dart';

class KitchenAppbar extends StatefulWidget {
  const KitchenAppbar({super.key});

  @override
  State<KitchenAppbar> createState() => _KitchenAppbarState();
}

class _KitchenAppbarState extends State<KitchenAppbar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.find<KitchenController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: controller.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return SizedBox(
            height: Get.size.height / 5,
            child: AppBar(
              backgroundColor: Get.theme.colorScheme.primary,
              title: const Text('Kitchen'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'search for Items',
                  onPressed: () {
                    // handle the press
                  },
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.offUntil(
                        GetPageRoute(
                            page: () => const StartScreen(),
                            transition: Transition.leftToRightWithFade),
                        (route) => false);
                  },
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                labelColor: Get.theme.colorScheme.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Get.theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(Get.size.width / 4),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Get.theme.colorScheme.primary, width: 2),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 10),
                labelStyle: Get.theme.textTheme.titleLarge,
                unselectedLabelColor: Get.theme.colorScheme.onBackground,
                controller: _tabController,
                tabs: controller.tabs,
              ),
            ),
          );
        });
  }
}
