import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingUtil extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingUtil({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: LoadingAnimationWidget.horizontalRotatingDots(
          color: color, size: size),
    );
  }
}
