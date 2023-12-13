import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';
import 'package:upmatev2/themes/app_font.dart';

import '../../themes/app_color.dart';
import '../../utils/loading.dart';
import '../global/line.dart';

class EditPage extends StatelessWidget {
  final int index;
  const EditPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    return GetBuilder<EditProfileController>(
        builder: (_) => WillPopScope(
            onWillPop: () async {
              controller.textEditingController.clear();
              controller.confirmPass.clear();
              controller.errorMessage = null;
              controller.errorConfPassMessage = null;
              Get.back();
              return Future.value(false);
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 110),
                      child: Column(
                        children: [
                          TextField(
                            obscureText:
                                controller.isPass(index).value ? true : false,
                            maxLines: controller.isPass(index).value ? 1 : null,
                            keyboardType: controller.isEmail(index).value
                                ? TextInputType.emailAddress
                                : TextInputType.text,
                            controller: controller.textEditingController,
                            onChanged: (text) {
                              controller.isEmptyText.value = text.isEmpty;
                              controller.update();
                            },
                            style: AppFont.defaultText,
                            maxLength: controller.maxLength[index],
                            decoration: InputDecoration(
                                helperText: controller.errorMessage?.value,
                                labelText:
                                    controller.data.keys.elementAt(index),
                                labelStyle: AppFont.defaultText,
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
                                  onTap: () =>
                                      controller.textEditingController.clear(),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                )),
                          ),
                          controller.isPass(index).value
                              ? TextField(
                                  obscureText: true,
                                  controller: controller.confirmPass,
                                  style: AppFont.defaultText,
                                  maxLength: controller.maxLength[index],
                                  decoration: InputDecoration(
                                      helperText: controller
                                          .errorConfPassMessage?.value,
                                      labelText:
                                          "Konfirmasi ${controller.data.keys.elementAt(index)}",
                                      labelStyle: AppFont.defaultText,
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
                                            controller.confirmPass.clear(),
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
                                        controller.textEditingController
                                            .clear();
                                        controller.confirmPass.clear();
                                        controller.errorMessage = null;
                                        controller.errorConfPassMessage = null;
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
                                        controller.data.keys.elementAt(index),
                                        textAlign: TextAlign.center,
                                        style: AppFont.semiLargeText.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () => controller.save(
                                            controller.data.keys
                                                .elementAt(index),
                                            controller.minLength[index],
                                            controller.maxLength[index]),
                                        child:
                                            Obx(() => controller.isLoading.value
                                                ? const SizedBox(
                                                    width: 50,
                                                    child: Center(
                                                        child: LoadingUtil(
                                                            size: 25,
                                                            color: Colors
                                                                .blueAccent)),
                                                  )
                                                : SizedBox(
                                                    width: 50,
                                                    child: Text(
                                                      "Simpan",
                                                      style: TextStyle(
                                                        color: controller
                                                                .textEditingController
                                                                .text
                                                                .isEmpty
                                                            ? Colors.grey
                                                            : Colors.blueAccent,
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
            )));
  }
}