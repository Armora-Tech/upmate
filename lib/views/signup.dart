import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/signup/signup_form.dart';
import '../routes/route_name.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  "let's_get_start_it".tr,
                  style: AppFont.text25.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SignupForm(),
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
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "sign_up_with".tr,
                          style: AppFont.text12.copyWith(
                              color: const Color.fromARGB(255, 130, 130, 130)),
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
                    Text(
                      "already_have_an_account".tr,
                      style: const TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                        onTap: () => Get.toNamed(RouteName.login),
                        child: Text(
                          "sign_in".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
