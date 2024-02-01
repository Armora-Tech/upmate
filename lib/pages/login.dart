import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/widgets/login/login_form.dart';

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
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 150,
                    child: Image.asset("assets/images/Upmate.png",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                Text("welcome_back".tr,
                    style:
                        AppFont.text25.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 20,
                ),
                const LoginForm(),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("forgot_password".tr,
                      style: AppFont.text12.copyWith(color: AppColor.black)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 193, 193, 193)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "sign_in_with".tr,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 130, 130, 130)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 193, 193, 193)),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: IconButton(
                        onPressed: () async {
                          controller.selectedLoginProvider =
                              LoginProvider.google;
                          await controller
                              .verifyEmail(controller.selectedLoginProvider!);
                        },
                        icon: Image.asset("assets/images/google.png",
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      height: 50,
                      child: IconButton(
                        onPressed: () async =>
                            await controller.login(LoginProvider.facebook),
                        icon: Image.asset("assets/images/facebook.png",
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't_have_an_account".tr,
                      style: const TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        controller.isLogin.value = false;
                        Get.toNamed(RouteName.signup);
                      },
                      child: Text("sign_up".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
