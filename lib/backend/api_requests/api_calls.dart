import '../../flutter_flow/flutter_flow_util.dart';
import '../cloud_functions/cloud_functions.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetOTPCall {
  static Future<ApiCallResponse> call({
    String? mail = '',
  }) {
    final body = '''
{"email":"$mail"}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getOTP',
      apiUrl: 'https://apis.upmate.armora-tech.com/otp/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AlgoQueryCall {
  static Future<ApiCallResponse> call({
    String? query = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AlgoQueryCall',
        'variables': {
          'query': query,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class ImageKitUploadCall {
  static Future<ApiCallResponse> call({
    String? ref = '',
    FFLocalFile? img,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'imageKitUpload',
      apiUrl: 'https://apis.upmate.armora-tech.com/imagekit/upload',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'ref': ref,
        'img': img,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}
