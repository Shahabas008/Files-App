import 'package:file_app/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                "Sign Up Page",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(hintText: "E-Mail"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                validator: ((value) {
                  if (value!.length < 6) {
                    return 'Password is too short';
                  } else {
                    return null;
                  }
                }),
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    minimumSize: Size(width, height * 0.05),
                    backgroundColor: Colors.teal[100]),
                onPressed: () {
                  controller.signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context);
                },
                child: const Text("SIGN UP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
