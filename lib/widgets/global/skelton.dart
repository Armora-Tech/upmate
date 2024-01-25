import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkelton extends StatelessWidget {
  const ShimmerSkelton(
      {super.key,
      required this.height,
      required this.width,
      this.borderRadius = 15,
      this.isCircle = false});

  final double height, width;
  final double borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            color: Colors.white,
            borderRadius:
                isCircle ? null : BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
