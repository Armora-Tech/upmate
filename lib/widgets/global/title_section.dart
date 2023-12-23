import 'package:flutter/material.dart';
import 'package:upmatev2/themes/app_font.dart';

class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        overflow: TextOverflow.visible,
        style: AppFont.text18.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
