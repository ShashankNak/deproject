import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/controller/auth/auth_controller.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/register_or_signin.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/sign_in_button.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/sign_in_google.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/text_field_confirm_pass.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/text_field_email.dart';
import 'package:pantry_plus/screens/pages/auth/widgets/text_field_pass.dart';
import 'package:pantry_plus/utils/const.dart';

import '../../../utils/Theme/theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(AuthController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder(
          init: controller,
          builder: (context) {
            return Stack(
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: true,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.miniStartTop,
                  floatingActionButton: FloatingActionButton.small(
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () {
                            Get.back();
                          },
                    child: const Icon(Icons.arrow_back),
                  ),
                  body: Container(
                    alignment: Alignment.center,
                    child: Card(
                      elevation: 4,
                      surfaceTintColor: Colors.amber,
                      margin: const EdgeInsets.all(30),
                      color: customColorScheme(Get.context!).primary,
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            opacity: 0.2,
                            image: AssetImage(
                              "assets/images/img1.png",
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(size.width / 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 40,
                                ),
                                Text(
                                  controller.isNewUser.value
                                      ? "Welcome New Pal!"
                                      : "Welcome Back!",
                                  style: customTextTheme(Get.context!)
                                      .bodyLarge!
                                      .copyWith(fontSize: size.width / 14),
                                ),
                                SizedBox(
                                  height: size.height / 80,
                                ),
                                const TextFieldEmail(),
                                SizedBox(
                                  height: size.height / 80,
                                ),
                                const TextFieldPass(),
                                SizedBox(
                                  height: size.height / 80,
                                ),
                                if (controller.isNewUser.value)
                                  const TextFieldConfirmPass(),
                                if (controller.isNewUser.value)
                                  SizedBox(
                                    height: size.height / 80,
                                  ),
                                const RegisterOrSignIn(),
                                const SignInButton(),
                                SizedBox(
                                  height: size.height / 90,
                                ),
                                Text(
                                  "or",
                                  style: customTextTheme(Get.context!)
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: size.width / 20),
                                ),
                                SizedBox(
                                  height: size.height / 90,
                                ),
                                const SignInGoogle(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (controller.isLoading.value) customLoadingIndicator()
              ],
            );
          }),
    );
  }
}
