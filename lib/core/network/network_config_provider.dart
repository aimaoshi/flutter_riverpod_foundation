import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/network_config.dart';

/// 由 [AppBootstrap] 覆盖，保证启动后的网络环境不可被页面随意修改。
final networkConfigProvider = Provider<NetworkConfig>(
  (ref) => NetworkConfig.fromBuildEnvironment(),
);
