// ignore_for_file: unnecessary_getters_setters, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    _nreset = await secureStorage.getInt('ff_nreset') ?? _nreset;
    _sreset = await secureStorage.getBool('ff_sreset') ?? _sreset;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  int _nreset = 0;
  int get nreset => _nreset;
  set nreset(int value) {
    _nreset = value;
    secureStorage.setInt('ff_nreset', value);
  }

  void deleteNreset() {
    secureStorage.delete(key: 'ff_nreset');
  }

  bool _sreset = false;
  bool get sreset => _sreset;
  set sreset(bool value) {
    _sreset = value;
    secureStorage.setBool('ff_sreset', value);
  }

  void deleteSreset() {
    secureStorage.delete(key: 'ff_sreset');
  }

  String _tiid = '';
  String get tiid => _tiid;
  set tiid(String value) {
    _tiid = value;
  }

  bool _isverified = false;
  bool get isverified => _isverified;
  set isverified(bool value) {
    _isverified = value;
  }

  bool _isFirstOpen = false;
  bool get isFirstOpen => _isFirstOpen;
  set isFirstOpen(bool value) {
    _isFirstOpen = value;
  }

  String _mainMenu = 'normal';
  String get mainMenu => _mainMenu;
  set mainMenu(String value) {
    _mainMenu = value;
  }

  bool _unused = false;
  bool get unused => _unused;
  set unused(bool value) {
    _unused = value;
  }

  bool _cs = false;
  bool get cs => _cs;
  set cs(bool value) {
    _cs = value;
  }

  bool _adstime = false;
  bool get adstime => _adstime;
  set adstime(bool value) {
    _adstime = value;
  }

  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool value) {
    _isloading = value;
  }

  List<Color> _interestColors = [
    const Color(0xffe6194B),
    const Color(0xff3cb44b),
    const Color(0xffffe119),
    const Color(0xff4363d8),
    const Color(0xfff58231),
    const Color(0xff911eb4),
    const Color(0xff42d4f4),
    const Color(0xfff032e6),
    const Color(0xffbfef45)
  ];
  List<Color> get interestColors => _interestColors;
  set interestColors(List<Color> value) {
    _interestColors = value;
  }

  void addToInterestColors(Color value) {
    _interestColors.add(value);
  }

  void removeFromInterestColors(Color value) {
    _interestColors.remove(value);
  }
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async => await write(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await write(key: key, value: value.toString());

  Future<int?> getInt(String key) async => int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await write(key: key, value: value.toString());

  Future<double?> getDouble(String key) async => double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await write(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async => await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter().convert(result).first.map((e) => e.toString()).toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await write(key: key, value: const ListToCsvConverter().convert([value]));
}
