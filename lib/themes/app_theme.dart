import 'package:flutter/material.dart';
import 'package:upmatev2/themes/app_color.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
      primaryColor: AppColor.primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Ubah sesuai keinginan Anda
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              foregroundColor: Colors.black45,
              elevation: 0.5,
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              backgroundColor: AppColor.primaryColor)),
      appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: AppColor.primaryColor,
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: "Nunito")),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium:
            TextStyle(fontSize: 14, color: Colors.black, fontFamily: "Nunito"),
      ),
      iconTheme: const IconThemeData(color: AppColor.black, size: 30),
      shadowColor: AppColor.shadowColor,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColor.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.primaryColor)),
          hintStyle: const TextStyle(fontSize: 16, fontFamily: "Nunito")));
}
