import 'package:get/get.dart';
import 'package:upmatev2/controllers/bottom_nav_controller.dart';
import 'package:upmatev2/controllers/chat_controller.dart';
import 'package:upmatev2/controllers/observer/dots_indicator_controller.dart';
import 'package:upmatev2/controllers/home_controller.dart';
import 'package:upmatev2/controllers/login_controller.dart';
import 'package:upmatev2/controllers/start_controller.dart';

import '../controllers/observer/action_post_controller.dart';

class StartBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartController>(() => StartController());
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put(HomeController(), permanent: true);
    Get.lazyPut<ChatController>(() => ChatController());
    Get.put(DostIndicatorController());
    Get.put(ActionPostController(), permanent: true);
  }
}
