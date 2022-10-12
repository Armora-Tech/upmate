import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetOTPCall {
  static Future<ApiCallResponse> call({
    String? mail = '',
  }) {
    final body = '''
{"email":"${mail}"}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getOTP',
      apiUrl: 'https://eowols238v8t5yi.m.pipedream.net',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddPostCall {
  static Future<ApiCallResponse> call({
    String? iid = '',
    String? name = '',
    String? owner = '',
    String? desc = '',
    String? tsmt = '',
    String? tags = '',
    String? image = '',
  }) {
    final body = '''
{
  "iid": "${iid}",
  "name": "${name}",
  "owner": "${owner}",
  "desc": "${desc}",
  "tsmt": "${tsmt}",
  "image": "${image}",
  "tags": "${tags}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addPost',
      apiUrl: 'https://upmate.armora-tech.com/recombee/addItem',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
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
