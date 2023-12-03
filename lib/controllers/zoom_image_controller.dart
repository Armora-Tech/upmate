import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZoomImageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final RxDouble minScale = 1.0.obs;
  final RxDouble maxScale = 2.0.obs;

  void resetZoom() {
    animation = Matrix4Tween(
            begin: transformationController.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.easeInToLinear));

    animationController.forward(from: 0);
  }

  @override
  void onInit() {
    transformationController = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() => transformationController.value = animation!.value);
    super.onInit();
  }

  @override
  void onClose() {
    transformationController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
