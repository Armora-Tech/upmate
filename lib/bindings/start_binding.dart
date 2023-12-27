import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';

class StartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<StartController>(() => StartController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
