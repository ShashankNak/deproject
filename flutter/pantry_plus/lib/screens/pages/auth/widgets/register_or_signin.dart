import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/auth/auth_controller.dart';

class RegisterOrSignIn extends StatelessWidget {
  const RegisterOrSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Align(
      alignment: Alignment.centerRight,
      child: GetBuilder(
          init: controller,
          builder: (context) {
            return TextButton(
                onPressed: () {
                  controller.toggleUser();
                },
                child: Text(
                  controller.isNewUser.value
                      ? "Already have an Account?"
                      : "Create an Account?",
                  style: Get.textTheme.bodyLarge!.copyWith(),
                ));
          }),
    );
  }
}
