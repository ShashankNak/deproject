import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/utils/Theme/theme.dart';

import '../../../../controller/auth/auth_controller.dart';

class TextFieldEmail extends StatelessWidget {
  const TextFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AuthController>();

    return TextField(
      enabled: !controller.isLoading.value,
      controller: controller.emailController.value,
      style: customTextTheme(Get.context!)
          .bodyLarge!
          .copyWith(fontSize: size.width / 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: size.width / 20, vertical: size.width / 20),
          hintStyle: customTextTheme(Get.context!)
              .labelLarge!
              .copyWith(color: Colors.grey, fontSize: 20),
          hintText: "Email",
          fillColor: Colors.white,
          filled: true,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 3)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide())),
    );
  }
}
