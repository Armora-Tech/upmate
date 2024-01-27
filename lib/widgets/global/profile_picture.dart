import 'package:flutter/material.dart';
import 'package:upmatev2/widgets/global/cached_network_image.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? imageURL;
  const ProfilePicture({super.key, this.imageURL, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CachedNetworkImageWidget(
          imageUrl: imageURL ??
              "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
          circularProgressSize: 20,
          heightPlaceHolder: size,
          widthPlaceHolder: size,
          radiusPlaceHolder: size,
          fit: BoxFit.cover),
    );
  }
}
