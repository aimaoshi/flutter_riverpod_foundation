/// 网络环境配置。
///
/// 可通过 `--dart-define=APP_ENV=production` 切换生产环境；基础框架默认
/// 使用测试环境，避免开发时误连生产服务。
///
/// 出于安全考虑，服务域名不写入源码，统一以 demo 域名占位；联调时替换为
/// 真实地址（或通过构建参数注入）后再发起请求。
class NetworkConfig {
  const NetworkConfig({
    required this.name,
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  final String name;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;

  static NetworkConfig fromBuildEnvironment() {
    const environment = String.fromEnvironment('APP_ENV', defaultValue: 'test');
    switch (environment) {
      case 'production':
        return const NetworkConfig(
          name: 'production',
          baseUrl: 'https://demo.com',
        );
      case 'dev2':
        return const NetworkConfig(
          name: 'dev2',
          baseUrl: 'https://demo.com',
        );
      case 'test':
      default:
        return const NetworkConfig(
          name: 'test',
          baseUrl: 'https://demo.com',
        );
    }
  }
}
