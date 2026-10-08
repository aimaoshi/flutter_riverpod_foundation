import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod_foundation/core/network/api_exception.dart';
import 'package:flutter_riverpod_foundation/core/network/api_response.dart';

class ApiClient {
  const ApiClient(this._dio);

  final Dio _dio;

  Future<ApiResponse> postJson(
    String path, {
    required Map<String, Object?> data,
  }) async {
    return _post(
      path,
      data: data,
      contentType: Headers.jsonContentType,
      encodeJson: true,
    );
  }

  /// 用于兼容旧 iRemote 登录等 `application/x-www-form-urlencoded` 接口。
  Future<ApiResponse> postForm(
    String path, {
    required Map<String, Object?> data,
  }) {
    return _post(
      path,
      data: data,
      contentType: Headers.formUrlEncodedContentType,
      encodeJson: false,
    );
  }

  Future<ApiResponse> _post(
    String path, {
    required Map<String, Object?> data,
    required String contentType,
    required bool encodeJson,
  }) async {
    try {
      // 显式编码，确保请求体一定是 JSON 字符串，而不是依赖 Dio 的隐式转换。
      final requestBody = encodeJson ? jsonEncode(data) : data;
      final response = await _dio.post<Object?>(
        path,
        data: requestBody,
        options: Options(
          contentType: contentType,
          // 给开发日志使用：JSON 字符串本身不打印，避免密码泄漏。
          extra: {'requestBodyFields': data.keys.toList(growable: false)},
        ),
      );
      final body = response.data;
      if (body is! Map) {
        throw const ApiException(message: '服务器返回的数据格式不正确');
      }
      return ApiResponse.fromJson(Map<String, Object?>.from(body));
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }
}
