import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/interceptors/network_log_interceptor.dart';
import 'package:flutter_riverpod_foundation/core/network/network_config_provider.dart';
import 'package:logger/logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(networkConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      // 与旧 WPHttpService 保持一致：默认请求使用表单编码，响应按 JSON 解析。
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(NetworkLogInterceptor(Logger()));
  ref.onDispose(dio.close);
  return dio;
});
