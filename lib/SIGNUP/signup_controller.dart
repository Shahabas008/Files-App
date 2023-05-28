import 'dart:developer';

import 'package:file_app/LOGIN/login_page.dart';
import 'package:file_app/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //user sign in
  void signUp({String? email, String? password, BuildContext? context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.snackbar(
            title: 'weak-password',
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils.snackbar(
            title: 'email-already-in-use',
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      log("$e");
    }
    Get.off(() => LoginPage());
  }

  //user sign out
  void signOut() {
    auth.signOut();
    Get.offAll(() => LoginPage());
  }
}
