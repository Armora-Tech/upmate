import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';

import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../../utils/input_validator.dart';
import '../global/loading.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final formField = GlobalKey<FormState>();
    controller.isEmailInvalid.value = false;
    controller.isPassInvalid.value = false;
    return GetBuilder<LoginController>(
      builder: (_) => Form(
        key: formField,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return InputValidator.emailMessageValidation(value, controller);
              },
              controller: controller.email,
              style: AppFont.text14,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                return InputValidator.passMessageValidation(value, controller);
              },
              keyboardType: controller.isVisible.value
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
              focusNode: controller.focusNode,
              controller: controller.pass,
              style: AppFont.text14,
              obscureText: controller.isVisible.value,
              decoration: InputDecoration(
                hintText: "password".tr,
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
                        : const Color(0xFF828282),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.isLoading.value
                  ? () => {}
                  : () async {
                      if (formField.currentState!.validate()) {
                        await controller.login(LoginProvider.email);
                      }
                    },
              child: Center(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Loading(size: 23, color: Colors.white)
                      : Text(
                          "sign_in".tr,
                          style: AppFont.text16.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
