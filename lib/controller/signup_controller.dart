import 'dart:developer';

import 'package:file_app/ui/homepage.dart';
import 'package:file_app/ui/login_page.dart';
import 'package:file_app/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //user sign in
  void signUp({String? email, String? password, BuildContext? context}) async {
    showDialog(
      context: context!,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
  }

  //user sign out
  void signOut() {
    auth.signOut();
    Get.offAll(() => LoginPage());
  }
}
