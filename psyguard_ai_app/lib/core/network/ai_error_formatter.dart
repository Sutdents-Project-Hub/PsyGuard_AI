import 'package:dio/dio.dart';

class AiRequestException implements Exception {
  const AiRequestException(this.message);

  final String message;

  @override
  String toString() => message;
}

String userFacingAiError(Object? error) {
  if (error is AiRequestException) {
    return error.message;
  }

  if (error is DioException) {
    final status = error.response?.statusCode;
    return switch (status) {
      400 => 'AI 請求格式不正確，請確認模型與參數設定',
      401 => 'AI 驗證失敗：API Key 無效、已過期，或不屬於這個服務',
      403 => 'AI 驗證被拒絕：目前 API Key 沒有使用此服務的權限',
      404 => '找不到 AI API 路徑：請確認 Base URL 可直接對應到 `/v1/chat/completions`',
      429 => 'AI 服務目前流量過高或額度不足，請稍後再試',
      int code when code >= 500 => 'AI 服務暫時異常，請稍後再試',
      _ => _messageForDioType(error),
    };
  }

  if (error is StateError) {
    const prefix = 'Bad state: ';
    final message = error.toString();
    if (message.startsWith(prefix)) {
      return message.substring(prefix.length);
    }
    return message;
  }

  return 'AI 服務目前無法使用，請稍後再試';
}

String _messageForDioType(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => '連線 AI 服務逾時，請確認網路與伺服器狀態',
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate => '無法連線到 AI 伺服器，請確認網址與憑證設定',
    DioExceptionType.cancel => 'AI 請求已取消',
    _ => 'AI 服務目前無法使用，請稍後再試',
  };
}
