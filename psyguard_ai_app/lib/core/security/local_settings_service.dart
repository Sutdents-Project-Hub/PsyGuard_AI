import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localSettingsServiceProvider = Provider<LocalSettingsService>((ref) {
  return LocalSettingsService(const FlutterSecureStorage());
});

class LocalSettingsService {
  LocalSettingsService(this._storage);

  final FlutterSecureStorage _storage;

  static const _lastExportPathKey = 'last_export_path';

  Future<void> setLastExportPath(String path) {
    return _storage.write(key: _lastExportPathKey, value: path);
  }

  Future<String?> getLastExportPath() {
    return _storage.read(key: _lastExportPathKey);
  }
}
