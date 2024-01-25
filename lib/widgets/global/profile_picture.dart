import 'package:flutter/material.dart';

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
      child: Image.network(
          imageURL ??
              "https://i.pinimg.com/736x/e5/93/09/e593098f04ed9c1f5fa05749ff0aff26.jpg",
          fit: BoxFit.cover),
    );
  }
}
