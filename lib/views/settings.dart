import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import '../controllers/settings_controller.dart';
import '../themes/app_font.dart';
import '../widgets/global/line.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return Scaffold(
      body: Stack(children: [
        GetBuilder<SettingsController>(
            builder: (_) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      TitleSection(title: "select_language".tr),
                      const SizedBox(
                        height: 20,
                      ),
                      RadioListTile<String>(
                        title: const Text('English'),
                        activeColor: AppColor.primaryColor,
                        value: 'en',
                        groupValue: controller.selectedLang.value,
                        onChanged: (value) {
                          controller.selectedLang.value = value!;
                          Get.updateLocale(
                              Locale(controller.selectedLang.value));
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Bahasa Indonesia'),
                        activeColor: AppColor.primaryColor,
                        value: 'id',
                        groupValue: controller.selectedLang.value,
                        selected: true,
                        onChanged: (value) {
                          controller.selectedLang.value = value!;
                          Get.updateLocale(
                              Locale(controller.selectedLang.value));
                        },
                      ),
                    ],
                  ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const SizedBox(
                                width: 28,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 28,
                                )),
                          ),
                          Text(
                            "settings".tr,
                            style: AppFont.text20
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 30,
                          )
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
      ]),
    );
  }
}
