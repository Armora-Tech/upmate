import 'package:get/get.dart';
import 'package:upmatev2/repositories/auth.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class StartController extends GetxController {
  final Auth _auth = Auth();
  UserModel? user;
  RxBool isLoading = false.obs;
  List<PostModel>? myPosts = [];

  @override
  void onInit() async {
    await _getUser();
    super.onInit();
  }

  Future<void> _getUser() async {
    isLoading.value = true;
    user = await _auth.getUserModel();
    await user!.getPosts();
    myPosts = user!.posts;
    isLoading.value = false;
    update();
  }

  Future<void> refreshStart() async {
    isLoading.value = true;
    await _getUser();
    isLoading.value = false;
    update();
  }
}
