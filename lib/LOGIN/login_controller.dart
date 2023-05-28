import 'package:file_app/HOME/homepage.dart';
import 'package:file_app/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // user login using google
  signUpWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
     await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //user logging with firebase
  signInWithFirebase(
      {String? email, String? password, BuildContext? context}) async {
    showDialog(
      context: context!,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
       await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        Utils.snackbar(
            title: 'user-not-found', message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.snackbar(
            title: 'wrong-password',
            message: 'Wrong password provided for that user.');
      }
    }
  }
}
