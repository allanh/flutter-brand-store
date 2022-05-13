import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> write(String key, String value) async {
    var writeData = await _storage.write(
        key: key, value: value, aOptions: _getAndroidOptions());
    return writeData;
  }

  Future<String?> read(String key) async {
    var readData =
        await _storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> delete(String key) async {
    var deleteData =
        await _storage.delete(key: key, aOptions: _getAndroidOptions());
    return deleteData;
  }

  Future<Map<String, String>> readAll() async {
    var allData = await _storage.readAll(aOptions: _getAndroidOptions());
    return allData;
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future<bool> containsKey(String key) async {
    var containsKey =
        await _storage.containsKey(key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }
}
