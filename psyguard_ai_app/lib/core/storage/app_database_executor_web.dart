import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openAppDatabaseExecutor({required String name}) {
  return driftDatabase(
    name: name,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

QueryExecutor openInMemoryDatabaseExecutor() {
  throw UnsupportedError('記憶體資料庫不支援 Web 平台');
}
