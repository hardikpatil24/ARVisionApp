// ignore_for_file: avoid_print

import 'package:cam/auth/login_screen.dart';
import 'package:cam/auth/user_model.dart';
import 'package:cam/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  signupUserwithEmail(String email, password, name) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("hi");
      if (FirebaseAuth.instance.currentUser != null) {
        UserModel userModel = UserModel();
        userModel.userPhone = '';
        userModel.email = FirebaseAuth.instance.currentUser!.email.toString();
        userModel.userId = FirebaseAuth.instance.currentUser!.uid.toString();

        userModel.name = name;
        try {
          var log = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid.toString())
              .set(userModel.asMap());
          print("Hello");
          Get.snackbar('Successful', 'User Signed Up Successfully',
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);

          return log;
        } on FirebaseException catch (e) {
          print(e.toString());
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.message}',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar('Successful',
          'We have sent you an password reset email, Please check your spam folder too',
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
      Get.off(() => const LoginScreen());
    } on FirebaseException catch (e) {
      Get.snackbar('Error', '${e.message}',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  signinUserwithEmail(String email, String password) async {
    try {
      var a = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return a;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.message}',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  logoutUser() async {
    try {
      await firebaseAuth.signOut();
      Get.snackbar('Successful', 'User Logged out Successfully',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
      Get.off(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.message}',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future signInWithGoogle(
    BuildContext context,
  ) async {
    GoogleSignInAccount? googleSignIn;
    try {
      googleSignIn = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleSignInAuthentication;
      googleSignInAuthentication = await googleSignIn!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        UserModel userModel = UserModel();
        userModel.userPhone = '';
        userModel.email = FirebaseAuth.instance.currentUser!.email.toString();
        userModel.userId = FirebaseAuth.instance.currentUser!.uid.toString();

        userModel.name =
            FirebaseAuth.instance.currentUser!.displayName.toString();
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid.toString())
              .set(userModel.asMap());
          Get.snackbar('Successful', 'User Signed Up Successfully',
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
          Get.off(() => const MainPage());
        } on FirebaseException catch (e) {
          Get.snackbar('Error', '${e.message}',
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM);
        }
      }
      if (kDebugMode) {
        print('Running TRY block of Google sign in ');
        print('USER CREDENTIALS FROM GOOGLE SIGN IN :$userCredential');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content: Text(
            e.message ?? '',
            style: const TextStyle(color: Colors.white),
          )));
      if (kDebugMode) {
        print('Running catch block of Google sign in ');
        print('Problem occurred in google sign in function from Auth class');
        print('The problem is: ${e.message}');
      }
    }
  }
}
