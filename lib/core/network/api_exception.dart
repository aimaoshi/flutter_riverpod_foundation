import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode, this.cause});

  final String message;
  final int? statusCode;
  final Object? cause;

  factory ApiException.fromDio(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final message = switch (exception.type) {
      DioExceptionType.connectionTimeout => '连接服务器超时',
      DioExceptionType.sendTimeout => '发送请求超时',
      DioExceptionType.receiveTimeout => '服务器响应超时',
      DioExceptionType.transformTimeout => '响应数据处理超时',
      DioExceptionType.connectionError => '网络连接失败，请检查网络',
      DioExceptionType.badResponse => '服务器请求失败（$statusCode）',
      DioExceptionType.cancel => '请求已取消',
      DioExceptionType.badCertificate => '服务器证书验证失败',
      DioExceptionType.unknown => '网络请求异常',
    };
    return ApiException(
      message: message,
      statusCode: statusCode,
      cause: exception,
    );
  }

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode)';
}
