import 'package:firebase_auth/firebase_auth.dart';
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

  String get username => user!.username;
  String? get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? "";
  String? get email => FirebaseAuth.instance.currentUser?.email ?? "";
  String? get photoURL =>
      FirebaseAuth.instance.currentUser?.photoURL ??
     "https://www.mmm.ucar.edu/sites/default/files/img/default-avatar.jpg";
}
