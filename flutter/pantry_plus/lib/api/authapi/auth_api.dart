import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthApi {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User? me;

  Future<bool> checkUserSignedIn() async {
    final value = await firestore.collection("users").doc(me!.uid).get();
    if (value.exists) {
      log("User already exists");
      return true;
    } else {
      log("User does not exist");
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return false;
      }
      log("message");

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      me = userCredential.user!;
      if (me == null) {
        log("UserCrendials not stored!");
      }
      log("Successfull login");
      return true;
    } catch (e) {
      log("Error during Google sign-in: $e");
      return false;
    }
  }

  Future<bool> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      await Future.delayed(const Duration(seconds: 2));

      log("Logout Successfully");
      return true;
    } catch (e) {
      log("Error signing out: $e");
      return false;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential oauthCredential =
          OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oauthCredential);
      log("Successful Apple login");

      return userCredential;
    } catch (e) {
      log("Error during Apple sign-in: $e");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      log("Logout Successfully");
      return true;
    } catch (e) {
      log("Error signing out: $e");
      return false;
    }
  }

  Future<UserCredential?> signInWithGitHub() async {
    const String clientId = 'YOUR_GITHUB_CLIENT_ID';
    const String clientSecret = 'YOUR_GITHUB_CLIENT_SECRET';
    // final Uri githubUrl = Uri.parse(
    //     'https://github.com/login/oauth/authorize?client_id=$clientId&scope=read:user user:email');
    final http.Response response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: <String, String>{
        'Accept': 'application/json',
      },
      body: <String, String>{
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': 'AUTHORIZATION_CODE',
      },
    );
    final Map<String, dynamic> data = json.decode(response.body);
    final String accessToken = data['access_token'];

    final AuthCredential credential =
        GithubAuthProvider.credential(accessToken);
    return await firebaseAuth.signInWithCredential(credential);
  }
}
