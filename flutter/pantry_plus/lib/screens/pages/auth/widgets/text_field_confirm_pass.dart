import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/auth/auth_controller.dart';
import 'package:pantry_plus/utils/Theme/theme.dart';

class TextFieldConfirmPass extends StatelessWidget {
  const TextFieldConfirmPass({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AuthController>();

    return GetBuilder(
        init: controller,
        builder: (context) {
          return TextField(
            enabled: !controller.isLoading.value,
            obscureText: controller.isCPassObscure.value,
            controller: controller.cPassController.value,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: controller.isLoading.value
                        ? () {}
                        : controller.toggleCPass,
                    icon: Icon(controller.isCPassObscure.value
                        ? Icons.visibility
                        : Icons.visibility_off_rounded)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width / 20, vertical: size.width / 20),
                hintStyle: customTextTheme(Get.context!)
                    .labelLarge!
                    .copyWith(color: Colors.grey, fontSize: 20),
                fillColor: Colors.white,
                hintText: "Confirm Password",
                filled: true,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 3)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 3)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide())),
          );
        });
  }
}
