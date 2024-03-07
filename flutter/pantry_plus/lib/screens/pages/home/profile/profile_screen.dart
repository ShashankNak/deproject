import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/home/profile/components/custom/profile_edit.dart';
import 'package:pantry_plus/screens/pages/home/profile/profile_appbar.dart';

import '../../../../controller/home/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return GetBuilder(
        init: controller,
        builder: (context) {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Column(
                  children: <Widget>[
                    ProfileAppbar(),
                    Expanded(child: ProfileEdit()),
                  ],
                );
        });
  }
}
