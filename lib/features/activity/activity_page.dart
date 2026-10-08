import 'package:flutter/material.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_keys.dart';
import 'package:flutter_riverpod_foundation/shared/ui/widgets/feature_placeholder.dart';

/// 活动 Tab。
class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FeaturePlaceholder(
      title: context.tr(LocaleKeys.tab_activity),
      message: context.tr(LocaleKeys.feature_in_progress),
      icon: Icons.local_activity_outlined,
    );
  }
}
