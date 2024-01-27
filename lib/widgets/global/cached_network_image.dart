import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double circularProgressSize;
  final double heightPlaceHolder;
  final double widthPlaceHolder;
  final double radiusPlaceHolder;
  const CachedNetworkImageWidget(
      {super.key,
      required this.imageUrl,
      required this.circularProgressSize,
      this.fit = BoxFit.contain,
      required this.heightPlaceHolder,
      required this.widthPlaceHolder,
      required this.radiusPlaceHolder});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      //   child: SizedBox(
      //     height: circularProgressSize,
      //     width: circularProgressSize,
      //     child: Center(
      //       child: CircularProgressIndicator(
      //           value: downloadProgress.progress,
      //           color: Colors.white,
      //           backgroundColor: Colors.grey,
      //           strokeWidth: 1.5),
      //     ),
      //   ),
      // ),

      imageBuilder: (context, imageProvider) => Container(
        clipBehavior: Clip.hardEdge,
        height: heightPlaceHolder,
        width: widthPlaceHolder,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusPlaceHolder),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: fit,
    );
  }
}
