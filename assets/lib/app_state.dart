import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';

class FFAppState {
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

  String tiid = '';

  bool isverified = false;

  bool isFirstOpen = false;

  String mainMenu = 'normal';

  bool unused = false;

  bool cs = false;
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
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