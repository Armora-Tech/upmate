import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/widgets/global/title_section.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settingsPage/app_bar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<SettingsController>(
            builder: (_) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  TitleSection(title: "select_language".tr),
                  const SizedBox(height: 20),
                  RadioListTile<String>(
                    title: const Text('English'),
                    activeColor: AppColor.primaryColor,
                    value: 'en',
                    groupValue: controller.selectedLang.value,
                    onChanged: (value) {
                      controller.selectedLang.value = value!;
                      Get.updateLocale(Locale(controller.selectedLang.value));
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
                      Get.updateLocale(Locale(controller.selectedLang.value));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SettingsAppBar()
        ],
      ),
    );
  }
}
