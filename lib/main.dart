import 'package:flutter/material.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/themes/app_theme.dart';
import 'package:upmatev2/views/login.dart';
import 'package:get/route_manager.dart';
import 'package:upmatev2/views/take_survey.dart';
import 'package:upmatev2/views/verify.dart';

import 'routes/routes.dart';

void main() {
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
      home: const TakeSurveyView(),
    );
  }
}
