import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/themes/app_theme.dart';
import 'package:upmatev2/views/login.dart';
import 'package:get/route_manager.dart';
import 'routes/routes.dart';

late List<CameraDescription> cameras;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
      initialBinding: LoginBinding(),
      getPages: AppPage.pages,
      home: const LoginView(),
    );
  }
}
