import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/repositories/auth.dart';
import 'package:upmatev2/repositories/user_repository.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class StartController extends GetxController {
  late final PermissionState permission;
  final Auth _auth = Auth();
  final UserRepository _userRepository = UserRepository();
  UserModel? user;
  RxBool isLoading = false.obs;
  RxBool isGettingMyPosts = false.obs;
  List<PostModel>? myPosts = [];
  List<PostModel>? myBookmarks = [];

  @override
  void onInit() async {
    await _getUser();
    permission = await PhotoManager.requestPermissionExtend();
    super.onInit();
  }

  Future<void> _getUser() async {
    isLoading.value = true;
    user = await _auth.getUserModel();
    await refreshMyPosts();
    isLoading.value = false;
    update();
  }

  Future<void> refreshMyPosts() async {
    isGettingMyPosts.value = true;
    myPosts = await _userRepository.getUserPosts();
    myBookmarks = await _userRepository.getBookmarks();
    isGettingMyPosts.value = false;
    update();
  }

  Future<void> refreshMyBookmarks() async {
    isGettingMyPosts.value = true;
    myBookmarks = await _userRepository.getBookmarks();
    isGettingMyPosts.value = false;
    update();
  }

  Future<void> refreshStart() async {
    isLoading.value = true;
    await _getUser();
    await refreshMyPosts();
    isLoading.value = false;
    update();
  }
}
