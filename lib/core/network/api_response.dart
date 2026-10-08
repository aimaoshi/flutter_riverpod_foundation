import 'dart:convert';

/// 兼容旧项目 `{resultCode, data}` 协议的原始服务端响应。
///
/// [data] 保持 dynamic：服务器字段的不确定性只会进入远端数据源和
/// Repository，不会传播到页面层。
class ApiResponse {
  const ApiResponse({
    required this.code,
    required this.message,
    required this.data,
    required this.raw,
  });

  final int code;
  final String message;
  final Object? data;
  final Map<String, Object?> raw;

  bool get isSuccess => code == 0;

  factory ApiResponse.fromJson(Map<String, Object?> json) {
    final rawCode = json['resultCode'] ?? json['code'] ?? -1;
    final code = rawCode is int ? rawCode : int.tryParse('$rawCode') ?? -1;
    return ApiResponse(
      code: code,
      message: '${json['message'] ?? json['errorinfo'] ?? ''}',
      // 新旧接口并存：旧接口把业务内容放在 `data`，登录接口则直接把
      // 业务字段放在根节点。后者保留完整响应，交给远端数据源转换 DTO。
      data: _decodeData(json['data'] ?? json),
      raw: json,
    );
  }

  static Object? _decodeData(Object? value) {
    if (value is! String) return value;
    try {
      return jsonDecode(value);
    } on FormatException {
      return value;
    }
  }
}
