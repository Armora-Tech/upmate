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
              "https://cdn4.iconfinder.com/data/icons/music-ui-solid-24px/24/user_account_profile-2-512.png",
          circularProgressSize: 20,
          heightPlaceHolder: size,
          widthPlaceHolder: size,
          radiusPlaceHolder: size,
          fit: BoxFit.cover),
    );
  }
}
