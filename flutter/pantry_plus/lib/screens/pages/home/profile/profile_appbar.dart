import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.colorScheme.primary,
      title: const Text('Profile'),
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
