import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiningAppbar extends StatelessWidget {
  const DiningAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.colorScheme.primary,
      title: const Text('Dining'),
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
