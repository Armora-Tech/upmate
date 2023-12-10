import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../utils/pick_image.dart';

class PostController extends GetxController {
  late final ScrollController scrollController;
  late TextEditingController description;
  late FocusNode focusNode;
  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;
  RxBool isBtnShown = false.obs;

  @override
  void onInit() async {
    scrollController = ScrollController();
    focusNode = FocusNode();
    description = TextEditingController();
    focusNode.addListener(() {});
    scrollController.addListener(() {
      if (scrollController.offset > 0) {
        isBtnShown.value = true;
      } else {
        isBtnShown.value = false;
      }
      update();
    });
    assetList = await PickImage().loadAssets();
    selectedAssetList.add(assetList[0]);
    update();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    description.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void addImage(AssetEntity image) {
    if (selectedAssetList.length != 1 && selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
      if (selectedIndex.value > selectedAssetList.length - 1) {
        selectedIndex.value = selectedAssetList.length - 1;
      }
      if (selectedAssetList.length == 1) {
        selectedIndex.value = 0;
      }

      selectedIndex = oldSelectedIndex;
    } else if (!selectedAssetList.contains(image)) {
      selectedAssetList.add(image);
    }
    update();
  }
}
