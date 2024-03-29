import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/bindings/start_binding.dart';
import 'package:upmatev2/pages/login.dart';
import 'package:upmatev2/pages/start_page.dart';
import 'package:upmatev2/themes/app_theme.dart';
import 'package:upmatev2/utils/translation.dart';

import 'routes/routes.dart';

late bool isLogin;
late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: 40 * 1024 * 1024); //40MB CACHE SIZE
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    isLogin = user == null;
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  PhotoManager.clearFileCache();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },
      theme: AppTheme.lightTheme,
      translations: Message(),
      locale: const Locale('en'),
      initialBinding: isLogin ? LoginBinding() : StartBinding(),
      getPages: AppPage.pages,
      home: isLogin ? const LoginView() : const StartView(),
    );
  }
}
