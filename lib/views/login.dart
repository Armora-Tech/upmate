import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  height: 10,
                ),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextField(
                        decoration: InputDecoration(
                      hintText: "Email",
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => TextField(
                        obscureText: controller.isVisible.value,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () => controller.changeVisibility(),
                            child: Icon(
                                controller.isVisible.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF828282)),
                          ),
                        ))),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
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
                        height: 30,
                        child: Image.asset(
                          "assets/images/google.png",
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        height: 30,
                        child: Image.asset(
                          "assets/images/facebook.png",
                          fit: BoxFit.cover,
                        ))
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
                        onTap: () => Get.toNamed(RouteName.signupView),
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
