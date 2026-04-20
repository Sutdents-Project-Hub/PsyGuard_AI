import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Web database runtime assets exist', () {
    expect(
      File('web/sqlite3.wasm').existsSync(),
      isTrue,
      reason: 'Drift Web 需要 sqlite3.wasm 才能正常開啟本地資料庫。',
    );
    expect(
      File('web/drift_worker.js').existsSync(),
      isTrue,
      reason: 'Drift Web 需要 drift_worker.js 才能正常初始化資料庫 worker。',
    );
  });

  test('Web branding points to PsyGuard AI icons', () {
    final manifest = File('web/manifest.json').readAsStringSync();
    final indexHtml = File('web/index.html').readAsStringSync();

    expect(manifest, contains('"name": "PsyGuard AI"'));
    expect(manifest, contains('"src": "icons/Icon-192.png"'));
    expect(manifest, contains('"src": "icons/Icon-512.png"'));
    expect(indexHtml, contains('href="icons/Icon-192.png"'));
    expect(indexHtml, contains('href="favicon.png"'));
    expect(indexHtml, contains('<title>PsyGuard AI</title>'));
  });
}
