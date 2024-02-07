import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/screens/pages/auth/auth_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/img2.png",
            fit: BoxFit.cover,
          ),
          Text(
            "Welcome to Pantry Plus",
            style: TextStyle(
                fontSize: size.shortestSide / 10, fontWeight: FontWeight.w600),
          ),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontSize: size.shortestSide / 10,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                      text: "Enhance your Kitchen Adventure,\n",
                      style: TextStyle(fontSize: size.shortestSide / 13)),
                  TextSpan(
                      text: "by Minimizing Waste and Maximizing Taste",
                      style: TextStyle(fontSize: size.shortestSide / 20)),
                ]),
          ),
          SizedBox(
            height: size.longestSide / 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(
                () => const AuthScreen(),
                transition: Transition.rightToLeftWithFade,
              );
            },
            style: ElevatedButton.styleFrom(
                minimumSize:
                    Size(size.shortestSide / 1.5, size.longestSide / 15),
                elevation: 3,
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text(
              "Get Started ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.shortestSide / 15,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
