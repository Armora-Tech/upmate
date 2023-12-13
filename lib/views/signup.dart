import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/signup_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import '../routes/route_name.dart';
import '../themes/app_color.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
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
                  "Let's get start it!",
                  style: AppFont.semiDoubleExtraLargeText
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<SignupController>(
                    builder: (_) => Form(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                                controller: controller.fullName,
                                style: AppFont.defaultText,
                                decoration: InputDecoration(
                                  hintText: "Nama Lengkap",
                                  helperText:
                                      controller.errorFullNameMessage?.value,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                                controller: controller.username,
                                style: AppFont.defaultText,
                                decoration: InputDecoration(
                                  helperText:
                                      controller.errorUsernameMessage?.value,
                                  hintText: "Username",
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                                controller: controller.email,
                                style: AppFont.defaultText,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  helperText:
                                      controller.errorEmailMessage?.value,
                                  hintText: "Email",
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                                focusNode: controller.focusNode,
                                controller: controller.pass,
                                maxLength: 32,
                                style: AppFont.defaultText,
                                obscureText: controller.isVisible.value,
                                decoration: InputDecoration(
                                  counterText: "",
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
                              height: 15,
                            ),
                            TextField(
                                focusNode: controller.confirmPassfocusNode,
                                controller: controller.confPass,
                                maxLength: 32,
                                style: AppFont.defaultText,
                                obscureText:
                                    controller.isConfirmPassVisible.value,
                                decoration: InputDecoration(
                                  counterText: "",
                                  helperText:
                                      controller.errorConfPassMessage?.value,
                                  hintText: "Konfirmasi Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.isConfirmPassVisible.toggle();
                                      controller.update();
                                    },
                                    child: Icon(
                                        controller.isConfirmPassVisible.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        size: 22,
                                        color: controller
                                                .isConfirmPassFocused.value
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
                                    : () => controller.signup(),
                                child: Center(
                                  child: Obx(() => controller.isLoading.value
                                      ? const SizedBox(
                                          height: 23,
                                          width: 23,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Sign Up",
                                          style: AppFont.semiLargeText.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )),
                                ))
                          ],
                        ))),
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
                          "Sign Up With",
                          style: AppFont.semiMediumText.copyWith(
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
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GestureDetector(
                        onTap: () => Get.toNamed(RouteName.login),
                        child: const Text(
                          "Sign In",
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
