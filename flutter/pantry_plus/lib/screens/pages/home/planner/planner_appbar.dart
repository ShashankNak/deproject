import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlannerAppbar extends StatelessWidget {
  const PlannerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.colorScheme.primary,
      title: const Text('Planner'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'search for Items',
          onPressed: () {
            // handle the press
          },
        ),
      ],
    );
  }
}
