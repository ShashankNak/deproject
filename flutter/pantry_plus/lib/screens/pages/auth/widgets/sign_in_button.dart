import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/utils/Theme/theme.dart';

import '../../../../controller/auth/auth_controller.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    final size = MediaQuery.of(context).size;
    return Obx(
      () => ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            fixedSize: Size(size.width / 1.2, size.height / 15)),
        onPressed: controller.isLoading.value
            ? () {}
            : controller.isNewUser.value
                ? controller.signUp
                : controller.signIn,
        child: Text(
          controller.isNewUser.value ? "Sign Up" : "Sign In",
          style: customTextTheme(Get.context!)
              .bodyLarge!
              .copyWith(color: Colors.black, fontSize: 30),
        ),
      ),
    );
  }
}
