import 'package:get/get.dart';
import 'package:upmatev2/controllers/post_detail_controller.dart';

class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
     Get.lazyPut<PostDetailController>(() => PostDetailController());
  }
  
}
