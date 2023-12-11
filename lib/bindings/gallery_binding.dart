import 'package:get/get.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';

class GalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(() => GalleryController(), fenix: true);
  }
}
