import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/utils/loading.dart';

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
                  height: 20,
                ),
                Text(
                  "Welcome back!",
                  style: AppFont.semiDoubleExtraLargeText
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<LoginController>(
                    builder: (_) => Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.email,
                                style: AppFont.defaultText,
                                decoration: InputDecoration(
                                  helperText:
                                      controller.errorEmailMessage?.value,
                                  hintText: "Email",
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                                focusNode: controller.focusNode,
                                controller: controller.pass,
                                style: AppFont.defaultText,
                                obscureText: controller.isVisible.value,
                                decoration: InputDecoration(
                                  helperText:
                                      controller.errorPassMessage?.value,
                                  hintText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.isVisible.toggle();
                                      controller.update();
                                    },
                                    child: Icon(
                                        controller.isVisible.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 22,
                                        color: controller.isFocused.value
                                            ? AppColor.primaryColor
                                            : const Color(0xFF828282)),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? () {}
                                    : () => controller.login(),
                                child: Center(
                                    child: Obx(
                                  () => controller.isLoading.value
                                      ? const LoadingUtil(
                                          size: 23, color: Colors.white)
                                      : Text(
                                          "Sign In",
                                          style: AppFont.semiLargeText.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                )))
                          ],
                        ))),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style:
                        AppFont.semiMediumText.copyWith(color: AppColor.black),
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
