import 'package:flutter/material.dart';
import 'package:upmatev2/themes/app_color.dart';
import 'package:upmatev2/themes/app_font.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColor.primaryColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(), backgroundColor: AppColor.primaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              foregroundColor: Colors.black45,
              elevation: 0.5,
              textStyle: AppFont.text16
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              backgroundColor: AppColor.primaryColor)),
      textTheme: TextTheme(
          headlineLarge: AppFont.text18,
          bodyLarge: AppFont.text18,
          bodyMedium: AppFont.text14),
      iconTheme: const IconThemeData(color: AppColor.black, size: 28),
      shadowColor: AppColor.shadowColor,
      splashFactory: InkRipple.splashFactory,
      highlightColor: const Color.fromARGB(88, 0, 0, 0),
      splashColor: const Color.fromARGB(88, 0, 0, 0),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionColor: Colors.grey,
          selectionHandleColor: AppColor.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
          counterStyle: AppFont.text10,
          helperStyle: AppFont.text10.copyWith(color: Colors.red),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.primaryColor)),
          hintStyle: AppFont.text14
              .copyWith(color: const Color.fromARGB(255, 144, 143, 143))));
}
