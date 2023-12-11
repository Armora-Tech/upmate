import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/edit_profile_controller.dart';

import '../../themes/app_color.dart';
import '../global/line.dart';

class EditPage extends StatelessWidget {
  final int index;
  const EditPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();
    return WillPopScope(
        onWillPop: () async {
          controller.textEditingController.clear();
          controller.confirmPass.clear();
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 110),
                child: controller.data.keys.elementAt(index).toLowerCase() !=
                        "password"
                    ? Column(
                        children: [
                          TextField(
                            controller: controller.textEditingController,
                            style: const TextStyle(fontSize: 14),
                            maxLength: controller.maxLength[index],
                            decoration: InputDecoration(
                                labelText:
                                    controller.data.keys.elementAt(index),
                                labelStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Nunito",
                                  color: Colors.black,
                                ),
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
                        ],
                      )
                    : Column(children: [
                        TextField(
                          obscureText: true,
                          controller: controller.textEditingController,
                          style: const TextStyle(fontSize: 14),
                          maxLength: controller.maxLength[index],
                          decoration: InputDecoration(
                              labelText: controller.data.keys.elementAt(index),
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Nunito",
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: AppColor.primaryColor)),
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
                        TextField(
                          obscureText: true,
                          controller: controller.confirmPass,
                          style: const TextStyle(fontSize: 14),
                          maxLength: controller.maxLength[index],
                          decoration: InputDecoration(
                              labelText:
                                  "Konfirmasi ${controller.data.keys.elementAt(index)}",
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Nunito",
                                color: Colors.black,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 1, color: AppColor.primaryColor)),
                              suffixIcon: GestureDetector(
                                onTap: () => controller.confirmPass.clear(),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              )),
                        )
                      ]),
              ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.textEditingController.clear();
                                    controller.confirmPass.clear();
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
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: const SizedBox(
                                      width: 50,
                                      child: Text(
                                        "Simpan",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    )),
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
        ));
  }
}
