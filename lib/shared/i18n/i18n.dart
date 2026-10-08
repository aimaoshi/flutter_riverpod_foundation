import 'package:flutter/widgets.dart';

import 'translation.dart';

/// 面向界面的国际化调用入口。
abstract final class I18n {
  static const supportedLocales = Translation.supportedLocales;
  static const localizationsDelegates = Translation.localizationsDelegates;

  static String tr(Locale locale, String key) => Translation.tr(locale, key);

  static String of(BuildContext context, String key) {
    return tr(Localizations.localeOf(context), key);
  }

  /// 无 [BuildContext] 时按当前系统语言读取翻译文本。
  static String system(String key) {
    return tr(WidgetsBinding.instance.platformDispatcher.locale, key);
  }
}

extension I18nBuildContext on BuildContext {
  String tr(String key) => I18n.of(this, key);
}
