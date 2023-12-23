import 'package:get/get.dart';

class SettingsController extends GetxController {
  late RxString selectedLang;

  @override
  void onInit() {
    selectedLang = "${Get.locale}".obs;
    super.onInit();
  }
}
