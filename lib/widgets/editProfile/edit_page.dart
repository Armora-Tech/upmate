import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/themes/app_font.dart';
import 'package:upmatev2/utils/input_validator.dart';

import '../../themes/app_color.dart';
import '../global/loading.dart';
import '../global/line.dart';

class EditPage extends StatelessWidget {
  final int index;
  const EditPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    final formField = GlobalKey<FormState>();
    return GetBuilder<EditProfileController>(
        builder: (_) => WillPopScope(
            onWillPop: () async {
              controller.inputText.clear();
              controller.confPass.clear();
              Get.back();
              return Future.value(false);
            },
            child: Scaffold(
              body: Form(
                key: formField,
                child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 110),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) => controller.inputValidation(
                                  value,
                                  controller.data!.keys.elementAt(index)),
                              obscureText:
                                  controller.isPass(index).value ? true : false,
                              maxLines:
                                  controller.isPass(index).value ? 1 : null,
                              keyboardType: controller.isEmail(index).value
                                  ? TextInputType.emailAddress
                                  : TextInputType.text,
                              controller: controller.inputText,
                              onChanged: (text) {
                                controller.isEmptyText.value = text.isEmpty;
                                controller.update();
                              },
                              style: AppFont.text14,
                              maxLength: controller.maxLength[index],
                              decoration: InputDecoration(
                                  helperMaxLines: 3,
                                  labelText:
                                      controller.data!.keys.elementAt(index),
                                  labelStyle: AppFont.text14,
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor)),
                                  suffixIcon: GestureDetector(
                                    onTap: () => controller.inputText.clear(),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  )),
                            ),
                            controller.isPass(index).value
                                ? TextFormField(
                                    validator: (value) => InputValidator
                                        .confPassMessageValidation(
                                            value, controller),
                                    obscureText: true,
                                    controller: controller.confPass,
                                    style: AppFont.text14,
                                    maxLength: controller.maxLength[index],
                                    decoration: InputDecoration(
                                        helperMaxLines: 3,
                                        labelText:
                                            "${"confrim".tr} ${controller.data!.keys.elementAt(index)}",
                                        labelStyle: AppFont.text14,
                                        errorBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColor.primaryColor)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: AppColor.primaryColor)),
                                        suffixIcon: GestureDetector(
                                          onTap: () =>
                                              controller.confPass.clear(),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                        )),
                                  )
                                : const SizedBox(),
                          ],
                        )),
                    Positioned(
                      top: 0,
                      child: Container(
                        color: Colors.white,
                        width: Get.width,
                        child: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.inputText.clear();
                                          controller.confPass.clear();
                                          Get.back();
                                        },
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: 40,
                                          child: const Icon(
                                            Icons.arrow_back,
                                            size: 25,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.data!.keys
                                              .elementAt(index),
                                          textAlign: TextAlign.center,
                                          style: AppFont.text16.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: controller
                                                      .inputText.text.isEmpty &&
                                                  controller.data!.keys
                                                          .elementAt(index)
                                                          .toLowerCase() !=
                                                      "bio"
                                              ? () {}
                                              : () {
                                                  if (formField.currentState!
                                                      .validate()) {
                                                    controller.save(controller
                                                        .data!.keys
                                                        .elementAt(index));
                                                  }
                                                },
                                          child:
                                              Obx(() =>
                                                  controller.isLoading.value
                                                      ? const SizedBox(
                                                          width: 50,
                                                          child: Center(
                                                              child: Loading(
                                                                  size: 25,
                                                                  color: Colors
                                                                      .blueAccent)),
                                                        )
                                                      : SizedBox(
                                                          width: 50,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              "save".tr,
                                                              style: TextStyle(
                                                                color: controller
                                                                            .inputText
                                                                            .text
                                                                            .isEmpty &&
                                                                        controller.data!.keys.elementAt(index).toLowerCase() !=
                                                                            "bio"
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .blueAccent,
                                                              ),
                                                            ),
                                                          ),
                                                        ))),
                                    ],
                                  ),
                                ),
                              ),
                              const Line(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
