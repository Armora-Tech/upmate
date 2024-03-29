import 'package:get/get.dart';
import 'package:upmatev2/controllers/login_controller.dart';

import '../controllers/bottom_nav_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<BottomNavController>(() => BottomNavController());
  }
}
