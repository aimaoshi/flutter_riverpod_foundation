import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/core/network/network_config.dart';
import 'package:flutter_riverpod_foundation/core/network/network_config_provider.dart';
import 'package:flutter_riverpod_foundation/core/storage/app_storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Initializes app-wide dependencies before the widget tree is created.
///
/// Keep only dependencies that must exist before routing here. Feature data and
/// device connections should be initialized later, when the user needs them.
class AppBootstrap {
  const AppBootstrap._({
    required this.preferences,
    required this.networkConfig,
  });

  final SharedPreferences preferences;
  final NetworkConfig networkConfig;

  static Future<AppBootstrap> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    return AppBootstrap._(
      preferences: await SharedPreferences.getInstance(),
      networkConfig: NetworkConfig.fromBuildEnvironment(),
    );
  }

  Widget buildRoot(Widget child) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        networkConfigProvider.overrideWithValue(networkConfig),
      ],
      child: child,
    );
  }
}
