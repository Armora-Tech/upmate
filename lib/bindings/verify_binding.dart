import 'package:get/get.dart';
import 'package:upmatev2/controllers/verify_controller.dart';


class VerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}
