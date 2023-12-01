import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';

import '../controllers/home_controller.dart';

class StartBinding implements Bindings {
  @override
  void dependencies() {
     Get.lazyPut<BottomNavController>(() => BottomNavController());
     Get.lazyPut<HomeController>(() => HomeController());

  }
}
