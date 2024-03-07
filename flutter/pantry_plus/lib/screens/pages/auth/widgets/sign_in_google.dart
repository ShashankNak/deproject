import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/auth/auth_controller.dart';
import 'package:pantry_plus/utils/Theme/theme.dart';

class SignInGoogle extends StatelessWidget {
  const SignInGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AuthController>();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            fixedSize: Size(size.width / 1.2, size.height / 15)),
        onPressed: controller.isLoading.value
            ? () {}
            : () => controller.signInWithGoogle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/googleimg.png",
              fit: BoxFit.cover,
              width: size.width / 15,
              height: size.width / 15,
            ),
            SizedBox(
              width: size.width / 20,
            ),
            Text(
              "Sign in with Google",
              style: customTextTheme(context)
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontSize: 20),
            ),
          ],
        ));
  }
}
