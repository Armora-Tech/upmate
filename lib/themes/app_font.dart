import 'package:flutter/material.dart';

class AppFont {
  static const baseText = TextStyle(
      color: Colors.black,
      fontFamily: "Nunito",
      overflow: TextOverflow.ellipsis);
  static final TextStyle smallText = baseText.copyWith(fontSize: 10);
  static final TextStyle semiMediumText = baseText.copyWith(fontSize: 12);
  static final TextStyle defaultText = baseText.copyWith(fontSize: 14);
  static final TextStyle semiLargeText = baseText.copyWith(fontSize: 16);
  static final TextStyle largeText = baseText.copyWith(fontSize: 18);
  static final TextStyle semiExtraLargeText = baseText.copyWith(fontSize: 20);
  static final TextStyle extraLargeText = baseText.copyWith(fontSize: 23);
  static final TextStyle semiDoubleExtraLargeText =
      baseText.copyWith(fontSize: 25);
  static final TextStyle doubleExtraLargeText = baseText.copyWith(fontSize: 28);
}
