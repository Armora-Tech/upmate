import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:upmatev2/controllers/camera_controller.dart';
import 'package:upmatev2/controllers/gallery_controller.dart';
import 'package:upmatev2/repositories/auth.dart';
import 'package:upmatev2/utils/pick_image.dart';

class Upload {
  final url = Uri.parse('https://armoratech.my.id/upmateimg/upload');
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final _pickImage = PickImage();

  Future<http.Response> uploadImage(File? asset) async {
    final img = asset;
    final Map<String, String> body = {
      'ref': "IMG-${Auth().getCurrentUserReference().id}${DateTime.now()}",
      'img': base64.encode(await img!.readAsBytes())
    };
    return await http.post(url, headers: headers, body: body);
  }

  Future<dynamic> uploadFromGallery(GalleryController controller) async {
    for (var asset in controller.selectedAssetList) {
      try {
        File? assetData = await asset.loadFile();
        final Directory tempDir = await getTemporaryDirectory();
        File newAsset = File(
            "${tempDir.path}/IMG-${Auth().getCurrentUserReference().id}${DateTime.now()}");
        await newAsset.create();
        List<int> bytes = await assetData!.readAsBytes();

        final uint8List = Uint8List.fromList(bytes);
        final result = await _pickImage.compressImage(uint8List);
        newAsset.writeAsBytesSync(result!);
        final response = await Upload().uploadImage(newAsset);

        if (response.statusCode == 200) {
          final responseData = response.body;
          final jsonResponse = jsonDecode(responseData);
          return jsonResponse['url'];
        } else {
          //error
          return;
        }
      } catch (error) {
        return;
      }
    }
  }

  Future<dynamic> uploadFromCamera(CameraViewController controller) async {
    try {
      List<int> bytes = await controller.image!.readAsBytes();
      final uint8List = Uint8List.fromList(bytes);
      final result = await _pickImage.compressImage(uint8List);
      controller.image!.writeAsBytesSync(result!);
      final response = await Upload().uploadImage(controller.image);
      if (response.statusCode == 200) {
        final responseData = response.body;
        final jsonResponse = jsonDecode(responseData);
        return jsonResponse['url'];
      } else {
        //error
        return;
      }
    } catch (error) {
      return;
    }
  }
}
