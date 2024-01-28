import 'package:get/get.dart';
import '../controllers/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchViewController>(() => SearchViewController());
  }
}
