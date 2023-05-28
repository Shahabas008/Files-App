import 'package:file_app/HOME/homepage.dart';
import 'package:file_app/SIGNUP/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went WRONG!'),
              );
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        "Login Page",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(hintText: "E-Mail"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            minimumSize: Size(width, height * 0.05),
                            backgroundColor: Colors.teal[100]),
                        onPressed: () {
                          controller.signInWithFirebase(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                        },
                        child: const Text(
                          "Login In",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            minimumSize: Size(width, height * 0.05),
                            backgroundColor: Colors.teal[100]),
                        onPressed: () {
                          controller.signUpWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/image/google_icon.png',
                              width: 25.0,
                              height: 25.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            const Text(
                              "Sign In with Google",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Create an account! "),
                          TextButton(
                              onPressed: () {
                                //navigate to sign up page
                                Get.to(() => SignUpPage());
                              },
                              child: const Text("SIGN UP"))
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
