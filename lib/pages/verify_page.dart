import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/signup_controller.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../widgets/global/loading.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key});

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
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Image.asset("assets/images/verify.png",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "verify_your_email".tr,
                  style: AppFont.text23.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "please_enter_the_4_digit_code_sent_to_youremail@example.com"
                      .tr,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            if (value.isEmpty) {
                              controller.inputOTP.value =
                                  controller.inputOTP.value.substring(
                                      0, controller.inputOTP.value.length - 1);
                            } else {
                              controller.inputOTP.value =
                                  controller.inputOTP.value + value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              controller.inputOTP.value =
                                  controller.inputOTP.value + value;
                              FocusScope.of(context).previousFocus();
                            }
                            if (value.isEmpty) {
                              controller.inputOTP.value =
                                  controller.inputOTP.value.substring(
                                      0, controller.inputOTP.value.length - 1);
                            } else {
                              controller.inputOTP.value =
                                  controller.inputOTP.value + value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).previousFocus();
                            }
                            if (value.isEmpty) {
                              controller.inputOTP.value =
                                  controller.inputOTP.value.substring(
                                      0, controller.inputOTP.value.length - 1);
                            } else {
                              controller.inputOTP.value =
                                  controller.inputOTP.value + value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 68,
                        width: 64,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.inputOTP.value =
                                  controller.inputOTP.value.substring(
                                      0, controller.inputOTP.value.length - 1);
                              FocusScope.of(context).previousFocus();
                            } else {
                              controller.inputOTP.value =
                                  controller.inputOTP.value + value;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "not_receiving_emails".tr,
                      style: const TextStyle(color: Color(0xFF505050)),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {},
                      child: Text("resend_email".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? () {}
                        : () async {
                            await controller.verifyOTP();
                            // final isOK = await authControl.checkOTP("123");
                            // print("CECK: $isOK");

                            // if(authControl.checkOTP(string)){
                            //
                            // }
                            // Get.toNamed(RouteName.takeSurvey)
                          },
                    child: Center(
                      child: controller.isLoading.value
                          ? const Loading(size: 23, color: Colors.white)
                          : Text(
                              "Verify",
                              style: AppFont.text16.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
