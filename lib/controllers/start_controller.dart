import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StartController extends GetxController {
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName ?? "";
  String? get email => FirebaseAuth.instance.currentUser?.email ?? "";
  String? get photoURL => FirebaseAuth.instance.currentUser?.photoURL ?? "https://i.imgflip.com/6yvpkj.jpg";
}
