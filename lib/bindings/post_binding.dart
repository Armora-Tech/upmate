import 'package:get/get.dart';
import '../controllers/camera_controller.dart';
import '../controllers/gallery_controller.dart';
import '../controllers/post_controller.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController(), fenix: true);
    Get.lazyPut<CameraViewController>(() => CameraViewController(),
        fenix: true);
    Get.lazyPut<GalleryController>(() => GalleryController(), fenix: true);
  }
}
