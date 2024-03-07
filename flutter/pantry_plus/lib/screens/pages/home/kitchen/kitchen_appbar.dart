import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/start_screen/start_screen.dart';

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
    );
  }
}
