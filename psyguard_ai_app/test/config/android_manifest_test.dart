import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'AndroidManifest includes INTERNET permission for AI requests',
    () async {
      final manifest = File(
        'android/app/src/main/AndroidManifest.xml',
      ).readAsStringSync();

      expect(
        manifest,
        contains('android.permission.INTERNET'),
        reason: 'AI 對話與報告功能需要網路權限才能呼叫遠端 API。',
      );
    },
  );
}
