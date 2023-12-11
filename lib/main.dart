import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:upmatev2/bindings/login_binding.dart';
import 'package:upmatev2/bindings/start_binding.dart';
import 'package:upmatev2/routes/route_name.dart';
import 'package:upmatev2/themes/app_theme.dart';
import 'package:upmatev2/views/login.dart';
import 'package:upmatev2/views/start.dart';

import 'routes/routes.dart';

late bool isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    isLogin = user == null;

    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
    }
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    const MyApp(),
  );
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
      initialRoute: isLogin ? RouteName.login : RouteName.start,
      initialBinding: isLogin ? LoginBinding() : StartBinding(),
      getPages: AppPage.pages,
      home: isLogin ? LoginView() : const StartView(),
    );
  }
}
