import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KitchenAppbar extends StatelessWidget {
  const KitchenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      ],
    );
  }
}
