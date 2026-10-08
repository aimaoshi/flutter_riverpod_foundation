import 'package:flutter/material.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';
import 'package:flutter_riverpod_foundation/shared/ui/widgets/feature_placeholder.dart';

/// 设备 Tab。
class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePlaceholder(
      title: context.tr(LocaleKeys.tab_devices),
      message: context.tr(LocaleKeys.feature_in_progress),
      icon: Icons.devices_outlined,
    );
  }
}
