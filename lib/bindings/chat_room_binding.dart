import 'package:get/get.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import '../controllers/camera_controller.dart';
import '../controllers/chat_room_controller.dart';
import '../controllers/observer/scroll_up_controller.dart';

class ChatRoomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRoomController>(() => ChatRoomController());
    Get.lazyPut<CameraViewController>(() => CameraViewController(),
        fenix: true);
    Get.lazyPut<GalleryController>(() => GalleryController(), fenix: true);
    Get.lazyPut<ScrollUpController>(() => ScrollUpController(), fenix: true);
  }
}
