import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/profile/profile_controller.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    return GetBuilder(
        init: controller,
        builder: (context) {
          return AppBar(
            backgroundColor: Get.theme.colorScheme.primary,
            title: const Text('Profile'),
            actions: <Widget>[
              IconButton(
                icon: controller.editMode.value
                    ? const Icon(Icons.check)
                    : const Icon(Icons.edit),
                tooltip: 'Confirm Edit',
                onPressed: controller.isLoading.value
                    ? () {}
                    : () {
                        // handle the press

                        if (controller.editMode.value) {
                          controller.updateProfile();
                        }
                        controller.editMode.toggle();
                        controller.update();
                      },
              ),
            ],
          );
        });
  }
}
