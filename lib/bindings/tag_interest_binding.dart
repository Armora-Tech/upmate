import 'package:get/get.dart';
import 'package:upmatev2/controllers/tag_interest_controller.dart';


class TagInterestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagInterestController>(() => TagInterestController());
  }
}
