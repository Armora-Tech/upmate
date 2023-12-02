import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/themes/app_theme.dart';
import 'package:upmatev2/views/login.dart';
import 'package:get/route_manager.dart';
import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
