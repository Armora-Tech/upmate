import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/utils/auth.dart';

import '../utils/cancellation.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final Auth _auth = Auth();
  CancellationToken _cancellationToken = CancellationToken();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: SizedBox(
                      height: 150,
                      child: Image.asset(
                        "assets/images/Upmate.png",
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        controller: controller.email,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "Email",
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => TextField(
                        focusNode: controller.focusNode,
                        controller: controller.pass,
                        style: const TextStyle(fontSize: 14),
                        obscureText: controller.isVisible.value,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () => controller.changeVisibility(),
                            child: Icon(
                                controller.isVisible.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 22,
                                color: controller.isFocused.value
                                    ? AppColor.primaryColor
                                    : const Color(0xFF828282)),
                          ),
                        ))),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          User? user = await _auth.signInWithEmailAndPassword(
                            controller.email.text,
                            controller.pass.text,
                          );
                          if (user != null) {
                            if (kDebugMode) {
                              print('User signed in: ${user.uid}');
                            }
                            await Get.toNamed(RouteName.start);
                          } else {
                            if (kDebugMode) {
                              print("Signin failed!");
                            }
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ))
                  ],
                )),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 193, 193, 193)),
                    )),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Sign In With",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 130, 130, 130)),
                        )),
                    Expanded(
                        child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 193, 193, 193)),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        child: IconButton(
                            onPressed: () async {
                              if (_cancellationToken.isCancelled) return;
                              _cancellationToken.cancel();
                              User? user = await _auth.signInWithGoogle();

                              if (user != null) {
                                if (kDebugMode) {
                                  print('User signed in: ${user.uid}');
                                }
                                await Get.toNamed(RouteName.start);
                              } else {
                                if (kDebugMode) {
                                  print("Signin failed!");
                                }
                              }
                              _cancellationToken = CancellationToken();
                            },
                            icon: Image.asset(
                              "assets/images/google.png",
                              fit: BoxFit.cover,
                            ))),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        height: 50,
                        child: IconButton(
                            onPressed: () async {
                              if (_cancellationToken.isCancelled) return;
                              _cancellationToken.cancel();
                              User? user = await _auth.signInWithFacebook();

                              if (user != null) {
                                if (kDebugMode) {
                                  print('User signed in: ${user.uid}');
                                }
                                await Get.toNamed(RouteName.start);
                              } else {
                                if (kDebugMode) {
                                  print("Signin failed!");
                                }
                              }
                              _cancellationToken = CancellationToken();
                            },
                            icon: Image.asset(
                              "assets/images/facebook.png",
                              fit: BoxFit.cover,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                        onTap: () => Get.toNamed(RouteName.signup),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
