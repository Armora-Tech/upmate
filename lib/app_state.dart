// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:up_mate/flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    _nreset = await secureStorage.getInt('ff_nreset') ?? _nreset;
    _sreset = await secureStorage.getBool('ff_sreset') ?? _sreset;
    _chatList = (await secureStorage.getStringList('ff_chatList'))?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        }).toList() ??
        _chatList;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  int _nreset = 0;
  int get nreset => _nreset;
  set nreset(int _value) {
    _nreset = _value;
    secureStorage.setInt('ff_nreset', _value);
  }

  void deleteNreset() {
    secureStorage.delete(key: 'ff_nreset');
  }

  bool _sreset = false;
  bool get sreset => _sreset;
  set sreset(bool _value) {
    _sreset = _value;
    secureStorage.setBool('ff_sreset', _value);
  }

  void deleteSreset() {
    secureStorage.delete(key: 'ff_sreset');
  }

  String _tiid = '';
  String get tiid => _tiid;
  set tiid(String _value) {
    _tiid = _value;
  }

  bool _isverified = false;
  bool get isverified => _isverified;
  set isverified(bool _value) {
    _isverified = _value;
  }

  bool _isFirstOpen = false;
  bool get isFirstOpen => _isFirstOpen;
  set isFirstOpen(bool _value) {
    _isFirstOpen = _value;
  }

  String _mainMenu = 'normal';
  String get mainMenu => _mainMenu;
  set mainMenu(String _value) {
    _mainMenu = _value;
  }

  bool _unused = false;
  bool get unused => _unused;
  set unused(bool _value) {
    _unused = _value;
  }

  bool _cs = false;
  bool get cs => _cs;
  set cs(bool _value) {
    _cs = _value;
  }

  List<dynamic> _chatList = [];
  List<dynamic> get chatList => _chatList;
  set chatList(List<dynamic> _value) {
    _chatList = _value;
    secureStorage.setStringList(
        'ff_chatList', _value.map((x) => jsonEncode(x)).toList());
  }

  void deleteChatList() {
    secureStorage.delete(key: 'ff_chatList');
  }

  void addToChatList(dynamic _value) {
    _chatList.add(_value);
    secureStorage.setStringList(
        'ff_chatList', _chatList.map((x) => jsonEncode(x)).toList());
  }

  void removeFromChatList(dynamic _value) {
    _chatList.remove(_value);
    secureStorage.setStringList(
        'ff_chatList', _chatList.map((x) => jsonEncode(x)).toList());
  }
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: ListToCsvConverter().convert([value]));
}
