import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signup_controller.dart';
import '../../themes/app_color.dart';
import '../../themes/app_font.dart';
import '../../utils/input_validator.dart';
import '../global/loading.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
    final formField = GlobalKey<FormState>();
    return GetBuilder<SignupController>(
      builder: (_) => Form(
        key: formField,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) =>
                  InputValidator.fullNameMessageValidation(value, controller),
              controller: controller.fullName,
              style: AppFont.text14,
              decoration:
                  InputDecoration(hintText: "full_name".tr, helperMaxLines: 3),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) =>
                  InputValidator.usernameMessageValidation(value, controller),
              controller: controller.username,
              style: AppFont.text14,
              decoration:
                  InputDecoration(helperMaxLines: 3, hintText: "username".tr),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) =>
                  InputValidator.emailMessageValidation(value, controller),
              controller: controller.email,
              style: AppFont.text14,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(helperMaxLines: 3, hintText: "Email"),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) =>
                  InputValidator.passMessageValidation(value, controller),
              focusNode: controller.focusNode,
              controller: controller.pass,
              maxLength: 32,
              style: AppFont.text14,
              obscureText: controller.isVisible.value,
              decoration: InputDecoration(
                counterText: "",
                helperMaxLines: 3,
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
                          : const Color(0xFF828282)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              validator: (value) =>
                  InputValidator.confPassMessageValidation(value, controller),
              focusNode: controller.confirmPassfocusNode,
              controller: controller.confPass,
              maxLength: 32,
              style: AppFont.text14,
              obscureText: controller.isConfirmPassVisible.value,
              decoration: InputDecoration(
                counterText: "",
                helperMaxLines: 3,
                hintText: "confirm_password".tr,
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
                      color: controller.isConfirmPassFocused.value
                          ? AppColor.primaryColor
                          : const Color(0xFF828282)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.isLoading.value
                  ? () {}
                  : () async {
                      if (formField.currentState!.validate()) {
                        await controller.signup();
                      }
                    },
              child: Center(
                child: Obx(
                  () => controller.isLoading.value
                      ? const Loading(size: 23, color: Colors.white)
                      : Text("sign_up".tr,
                          style: AppFont.text16.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
