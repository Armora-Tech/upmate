import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../utils/pick_image.dart';

class PostController extends GetxController {
  AssetEntity? selectedEntity;
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  RxInt selectedIndex = 0.obs;
  RxInt oldSelectedIndex = 0.obs;

  @override
  void onInit() async {
    assetList = await PickImage().loadAssets();
    selectedAssetList.add(assetList[0]);
    super.onInit();
    update();
  }

  void addImage(AssetEntity image) {
    if (selectedAssetList.length != 1 && selectedAssetList.contains(image)) {
      selectedAssetList.remove(image);
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
