import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/home/profile/profile_controller.dart';
import 'package:pantry_plus/utils/Theme/colors.dart';
import 'custom/clip_shadow_path.dart';
import 'custom/custom_clipper.dart';

class ProfileUIComponent extends StatelessWidget {
  const ProfileUIComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return GetBuilder(
        init: controller,
        builder: (context) {
          return Column(
            children: [
              Stack(
                children: [
                  ClipShadowPath(
                    clipper: MyClipper(
                        start: const Offset(0, 1 / 1.35),
                        firstStart: const Offset(1.0 / 8, 1 / 1.25),
                        firstEnd: const Offset(1 / 2.2, 1 / 1.3),
                        secondStart: const Offset(1 / 1.2, 1 / 1.4),
                        secondEnd: const Offset(1, 1 / 1.2),
                        end: const Offset(1, 0)),
                    shadow: const BoxShadow(
                      color: Color.fromARGB(199, 158, 158, 158),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 10,
                    ),
                    child: Container(
                      height: Get.size.height / 3 + 100,
                      width: Get.size.width,
                      decoration: const BoxDecoration(
                        color: CUSTOM_COLOR1,
                      ),
                    ),
                  ),
                  ClipShadowPath(
                    clipper: MyClipper(
                        start: const Offset(0, 1 / 1.1),
                        firstStart: const Offset(1.0 / 5, 1),
                        firstEnd: const Offset(1 / 2.5, 1 / 1.1),
                        secondStart: const Offset(1 / 1.2, 1 / 1.4),
                        secondEnd: const Offset(1, 1 / 1.2),
                        end: const Offset(1, 0)),
                    shadow: const BoxShadow(
                      color: Color.fromARGB(198, 121, 86, 50),
                      offset: Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: 10,
                    ),
                    child: Container(
                      height: Get.size.height / 3,
                      width: Get.size.width,
                      decoration: const BoxDecoration(
                        color: CUSTOM_COLOR2,
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.size.height / 30,
                    left: Get.size.width / 4,
                    child: Stack(
                      children: [
                        Material(
                          elevation: 20,
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.black,
                                  width: Get.size.shortestSide / 200)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Get.size.width / 2)),
                            child: controller.newImage.value ==
                                        controller.user.value.imageUrl ||
                                    controller.user.value.imageUrl == ""
                                ? CachedNetworkImage(
                                    imageUrl: controller.user.value.imageUrl,
                                    height: Get.size.width / 2,
                                    width: Get.size.width / 2,
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => SizedBox(
                                        width: Get.size.shortestSide / 4,
                                        height: Get.size.shortestSide / 4,
                                        child:
                                            const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/profile.jpeg',
                                      height: Get.size.width / 2,
                                      width: Get.size.width / 2,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.file(
                                    File(controller.newImage.value),
                                    height: Get.size.width / 2,
                                    width: Get.size.width / 2,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        if (controller.editMode.value)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: Get.size.height / 15,
                              height: Get.size.height / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Get.theme.colorScheme.onPrimary
                                      .withOpacity(0.6)),
                              child: controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: Get.size.height / 30,
                                        color:
                                            Get.theme.colorScheme.onSecondary,
                                      ),
                                      onPressed:
                                          controller.showBottomSheetForImage,
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
