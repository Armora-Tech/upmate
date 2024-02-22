import 'package:get/get.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import '../controllers/camera_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/observer/scroll_up_controller.dart';

class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<CameraViewController>(() => CameraViewController(),
        fenix: true);
    Get.lazyPut<GalleryController>(() => GalleryController(), fenix: true);
    Get.lazyPut<ScrollUpController>(() => ScrollUpController(), fenix: true);
  }
}
