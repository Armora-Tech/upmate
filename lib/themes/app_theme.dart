import 'package:flutter/material.dart';
import 'package:upmatev2/themes/app_color.dart';

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
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Nunito",
                overflow: TextOverflow.ellipsis,
              ),
              backgroundColor: AppColor.primaryColor)),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            overflow: TextOverflow.ellipsis),
        bodyLarge: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            overflow: TextOverflow.ellipsis),
        bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: "Nunito",
            overflow: TextOverflow.ellipsis),
      ),
      iconTheme: const IconThemeData(color: AppColor.black, size: 30),
      shadowColor: AppColor.shadowColor,
      splashFactory: InkRipple.splashFactory,
      highlightColor: const Color.fromARGB(88, 0, 0, 0),
      splashColor: const Color.fromARGB(88, 0, 0, 0),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionColor: Colors.grey,
          selectionHandleColor: AppColor.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
          helperStyle: const TextStyle(
            fontSize: 10,
            fontFamily: "Nunito",
            color: Colors.red,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: AppColor.primaryColor)),
          hintStyle: const TextStyle(
              fontSize: 14,
              fontFamily: "Nunito",
              overflow: TextOverflow.ellipsis)));
}
