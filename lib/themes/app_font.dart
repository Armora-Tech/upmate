import 'package:flutter/material.dart';

class AppFont {
  static const baseText = TextStyle(
      color: Colors.black,
      fontFamily: "Nunito",
      overflow: TextOverflow.ellipsis);
  static final TextStyle text10 = baseText.copyWith(fontSize: 10);
  static final TextStyle text12 = baseText.copyWith(fontSize: 12);
  static final TextStyle text14 = baseText.copyWith(fontSize: 14);
  static final TextStyle text16 = baseText.copyWith(fontSize: 16);
  static final TextStyle text18 = baseText.copyWith(fontSize: 18);
  static final TextStyle text20 = baseText.copyWith(fontSize: 20);
  static final TextStyle text23 = baseText.copyWith(fontSize: 23);
  static final TextStyle text25 =
      baseText.copyWith(fontSize: 25);
  static final TextStyle text28 = baseText.copyWith(fontSize: 28);
}
