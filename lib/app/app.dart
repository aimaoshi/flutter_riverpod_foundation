import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_foundation/app/router/app_router.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/i18n.dart';
import 'package:flutter_riverpod_foundation/shared/i18n/locale_controller.dart';
import 'package:flutter_riverpod_foundation/shared/ui/style/theme.dart';

class KeempleFoundationApp extends ConsumerWidget {
  const KeempleFoundationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      title: 'Flutter Riverpod Foundation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      locale: locale,
      localizationsDelegates: I18n.localizationsDelegates,
      supportedLocales: I18n.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
