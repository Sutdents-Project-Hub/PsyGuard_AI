import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openAppDatabaseExecutor({required String name}) {
  return driftDatabase(
    name: name,
    native: const DriftNativeOptions(shareAcrossIsolates: true),
  );
}

QueryExecutor openInMemoryDatabaseExecutor() {
  return NativeDatabase.memory();
}
