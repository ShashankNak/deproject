import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pantry_plus/api/authapi/auth_api.dart';
import 'package:pantry_plus/api/firebase/firebase_database.dart';
import 'package:pantry_plus/data/model/user_details_model.dart';
import 'package:pantry_plus/screens/pages/home/home_screen.dart';
import 'package:pantry_plus/utils/const.dart';

class AuthController extends GetxController {
  var isNewUser = false.obs; //checking for new user
  var isPassObscure = true.obs; //visibility of password
  var isCPassObscure = true.obs; //visibility of password
  var emailController = (TextEditingController()).obs; //controller for email
  var passController = (TextEditingController()).obs; //controller for password
  var cPassController =
      (TextEditingController()).obs; //controller for confirm password

  var isLoading = (false).obs;

  final AuthApi auth = AuthApi();

  //togglling between new or old user
  void toggleUser() {
    isNewUser(!isNewUser.value);
    update();
  }

  //toggling for visible and hidden password
  togglePass() {
    isPassObscure(!isPassObscure.value);
    update();
  }

  //toggling for visible and hidden confirm password
  toggleCPass() {
    isCPassObscure(!isCPassObscure.value);
    update();
  }

  Future<void> signInWithGoogle() async {
    isLoading(true);
    update();
    final logged = await auth.signInWithGoogle();
    final isAlreadyExist = await auth.checkUserSignedIn();

    //logic for storing the user on firestore database
    if (logged != null && !isAlreadyExist) {
      log("new User");
      final user = UserDetailsModel(
          mId: "",
          fId: logged.uid,
          name: logged.displayName ?? "",
          email: logged.email ?? "",
          imageUrl: logged.photoURL ?? "",
          birthdate: "",
          gender: Gender.none,
          height: "",
          weight: "",
          preference: "");
      await FirebaseDatabase.storeUserDetails(user);
    }

    isLoading(false);
    update();
    if (logged == null) {
      Get.snackbar("User Not Signed IN", "Try Again later");
      return;
    }

    Get.offUntil(
        GetPageRoute(
            page: () => const HomeScreen(),
            transition: Transition.rightToLeftWithFade),
        (route) => false);
  }

  //email and password validation
  bool validation() {
    try {
      var email = emailController.value.text.trim();
      String emailRegex =
          r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+)$';
      if (RegExp(emailRegex).hasMatch(email)) {
        log('Valid email address');
        if (passController.value.text.trim().length >= 6) {
          if (!isNewUser.value ||
              passController.value.text.trim() ==
                  cPassController.value.text.trim()) {
            return true;
          } else {
            throw "Password doesn't match";
          }
        } else {
          throw 'Password atleast 6 characters';
        }
      } else {
        throw 'Invalid email address';
      }
    } catch (e) {
      constSnackBar(title: e.toString());
      return false;
    }
  }

  //for signing in User
  void signIn() async {
    try {
      isLoading(true);
      update();
      Get.focusScope!.unfocus();
      if (validation()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.value.text.trim(),
            password: passController.value.text.trim());

        emailController.value.clear();
        passController.value.clear();
        cPassController.value.clear();
        update();
        Get.offUntil(
            GetPageRoute(
                page: () => const HomeScreen(),
                transition: Transition.rightToLeftWithFade),
            (route) => false);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-credential") {
        constSnackBar(title: "Invalid Credentials");
      } else {
        constSnackBar(title: error.toString());
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  //for sign up new User
  void signUp() async {
    Get.focusScope!.unfocus();
    if (validation()) {
      try {
        isLoading(true);
        update();
        final userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.value.text.trim(),
                password: passController.value.text.trim());

        log("Uid: ${userCredentials.user!.uid}");
        emailController.value.clear();
        passController.value.clear();
        cPassController.value.clear();

        log("new User");
        final user = UserDetailsModel(
            mId: "",
            fId: userCredentials.user!.uid,
            name: "",
            email: userCredentials.user!.email ?? "",
            imageUrl: "",
            birthdate: "",
            gender: Gender.none,
            height: "",
            weight: "",
            preference: "");
        await FirebaseDatabase.storeUserDetails(user);
        update();

        Get.offUntil(
            GetPageRoute(
                page: () => const HomeScreen(),
                transition: Transition.rightToLeftWithFade),
            (route) => false);
      } on FirebaseAuthException catch (error) {
        if (error.code == "email-already-in-use") {
          constSnackBar(title: "Email Already in Use");
        } else {
          constSnackBar(title: error.code.toString());
        }
      } finally {
        isLoading(false);
        update();
      }
    }
  }
}
