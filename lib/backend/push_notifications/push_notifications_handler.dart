// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          params: parameterData.params,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Center(
            child: Image.asset(
              'assets/images/Upmate_Splash.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get params => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => const ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'VerifPage': (data) async => ParameterData(
        allParams: {
          'code': getParameter<String>(data, 'code'),
          'mail': getParameter<String>(data, 'mail'),
          'name': getParameter<String>(data, 'name'),
          'pw': getParameter<String>(data, 'pw'),
          'isVerified': getParameter<bool>(data, 'isVerified'),
          'username': getParameter<String>(data, 'username'),
        },
      ),
  'LoginPage': ParameterData.none(),
  'SignupPage': ParameterData.none(),
  'surveyPage': ParameterData.none(),
  'interestPage': (data) async => ParameterData(
        allParams: {
          'ijob': getParameter<String>(data, 'ijob'),
        },
      ),
  'explorePage': ParameterData.none(),
  'mainPage': ParameterData.none(),
  'postDetail': (data) async => ParameterData(
        allParams: {
          'postRef': getParameter<String>(data, 'postRef'),
        },
      ),
  'notificationPage': ParameterData.none(),
  'newPostPage': (data) async => ParameterData(
        allParams: {
          'prevPage': getParameter<String>(data, 'prevPage'),
        },
      ),
  'chatPage': (data) async => ParameterData(
        allParams: {
          'chatUser': await getDocumentParameter<UsersRecord>(
              data, 'chatUser', UsersRecord.serializer),
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'allChatPage': ParameterData.none(),
  'createChatPage': ParameterData.none(),
  'createGroupChat': ParameterData.none(),
  'premiumPage': ParameterData.none(),
  'resetPassword': ParameterData.none(),
  'confirmResetPass': ParameterData.none(),
  'accountPage': ParameterData.none(),
  'bookmarkDetailPage': (data) async => ParameterData(
        allParams: {
          'whatFor': getParameter<String>(data, 'whatFor'),
        },
      ),
  'editProfile': ParameterData.none(),
  'appInfo': ParameterData.none(),
  'bookmarkListPage': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    if (kDebugMode) {
      print('Error parsing parameter data: $e');
    }
    return {};
  }
}
