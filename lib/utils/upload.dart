import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';
import 'package:upmatev2/repositories/auth.dart';

class Upload {
  final url = Uri.parse('https://armoratech.my.id/upmateimg/upload');
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  Future<http.Response> uploadImage(AssetEntity asset) async {
    final img = await asset.file;
    final Map<String, String> body = {
      'ref': "IMG-${Auth().getCurrentUserReference().id}${DateTime.now()}",
      'img': base64.encode(await img!.readAsBytes())
    };
    return await http.post(url, headers: headers, body: body);
  }
}
