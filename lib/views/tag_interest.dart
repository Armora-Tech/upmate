import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/controllers/signup_controller.dart';
import 'package:upmatev2/themes/app_color.dart';

import '../routes/route_name.dart';
import '../themes/app_font.dart';

class TagInterestView extends StatelessWidget {
  const TagInterestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tag Interest",
                        style: AppFont.text28
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dapatkan rekomendasi konten hasil personalisasi Anda. Anda dapat memilih hingga 4 opsi",
                        style: AppFont.text12.copyWith(color: Colors.grey),
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Apakah kamu suka logika matematika ?",
                          style: AppFont.text16
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          runAlignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: List.generate(
                              controller.tags.length,
                              (index) =>
                                  GetBuilder<SignupController>(builder: (_) {
                                    bool isSelectedTags = controller
                                        .selectedTags
                                        .contains(controller.tags[index]);
                                    return Material(
                                      clipBehavior: Clip.hardEdge,
                                      elevation: 0,
                                      color: isSelectedTags
                                          ? AppColor.primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        onTap: () =>
                                            controller.toggleInterest(index),
                                        child: Container(
                                          width: Get.width / 2 - 45,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: isSelectedTags
                                                      ? AppColor.primaryColor
                                                      : AppColor.lightGrey)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "#",
                                                overflow: TextOverflow.visible,
                                                style: AppFont.text12.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: isSelectedTags
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.tags[index],
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: AppFont.text12
                                                      .copyWith(
                                                          color: isSelectedTags
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                        onPressed: () => Get.toNamed(RouteName.start),
                        child: const Center(
                            child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
