import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChatBar extends StatelessWidget {
  const ShimmerChatBar({super.key});

  @override
  Widget build(BuildContext context) {
    double defaultRadius = 20;
    double taperRadius = 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 120),
        Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 3),
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultRadius),
                    topRight: Radius.circular(defaultRadius),
                    bottomLeft: Radius.circular(defaultRadius),
                    bottomRight: Radius.circular(taperRadius)),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 3),
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultRadius),
                    topRight: Radius.circular(taperRadius),
                    bottomLeft: Radius.circular(defaultRadius),
                    bottomRight: Radius.circular(taperRadius)),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 3),
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultRadius),
                    topRight: Radius.circular(taperRadius),
                    bottomLeft: Radius.circular(defaultRadius),
                    bottomRight: Radius.circular(defaultRadius)),
              ),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(left: 10, bottom: 3, top: 10),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultRadius),
                  topRight: Radius.circular(defaultRadius),
                  bottomLeft: Radius.circular(taperRadius),
                  bottomRight: Radius.circular(defaultRadius)),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(left: 10, bottom: 3),
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(taperRadius),
                  topRight: Radius.circular(defaultRadius),
                  bottomLeft: Radius.circular(taperRadius),
                  bottomRight: Radius.circular(defaultRadius)),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(left: 10, bottom: 3),
            height: 50,
            width: 230,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(taperRadius),
                  topRight: Radius.circular(defaultRadius),
                  bottomLeft: Radius.circular(defaultRadius),
                  bottomRight: Radius.circular(defaultRadius)),
            ),
          ),
        ),
      ],
    );
  }
}
