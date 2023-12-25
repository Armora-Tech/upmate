import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:upmatev2/repositories/auth.dart';

import '../models/user_model.dart';

class StartController extends GetxController {
  final Auth _auth = Auth();
  UserModel? user;

  @override
  void onInit() async {
    await _getUser();
    super.onInit();
  }

  Future<void> _getUser() async {
    user = await _auth.getUserModel();
  }

  String get usernameWithAt => user?.username == ""
      ? "@${displayName!.replaceAll(" ", "").toLowerCase()}"
      : "@${user!.username.toLowerCase()}";
  String? get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? "";
  String? get email => FirebaseAuth.instance.currentUser?.email ?? "";
  String? get photoURL =>
      FirebaseAuth.instance.currentUser?.photoURL ??
      "https://i.imgflip.com/6yvpkj.jpg";
}
