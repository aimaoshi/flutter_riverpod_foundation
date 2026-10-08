import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// 开发日志按“请求 url / 参数 / 返回结果”输出，并隐藏敏感字段。
class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor(this._logger);

  final Logger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 暂存已脱敏参数，等响应回来后在同一个日志框内一次性输出。
    options.extra['_logParameters'] = _redact(options.data);
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    _logger.d(
      '请求url: ${options.uri}\n'
      '参数: ${options.extra['_logParameters']}\n'
      '返回结果: ${_redact(response.data)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    _logger.w(
      '请求url: ${options.uri}\n'
      '参数: ${options.extra['_logParameters']}\n'
      '返回结果: 请求异常（${err.type}）',
    );
    handler.next(err);
  }

  Object? _redact(Object? value) {
    if (value is String) {
      try {
        return jsonEncode(_redact(jsonDecode(value)));
      } on FormatException {
        return value;
      }
    }
    if (value is Map) {
      return value.map<String, Object?>((key, item) {
        const sensitiveKeys = {
          'password',
          'token',
          'tokenid',
          'securitytoken',
          'usertoken',
          'logincookie',
        };
        return MapEntry(
          '$key',
          sensitiveKeys.contains('$key'.toLowerCase()) ? '***' : _redact(item),
        );
      });
    }
    if (value is Iterable) return value.map(_redact).toList(growable: false);
    return value;
  }
}
