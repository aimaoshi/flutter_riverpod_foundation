import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'locales/locale_en.dart';
import 'locales/locale_fr.dart';
import 'locales/locale_he.dart';
import 'locales/locale_ja.dart';
import 'locales/locale_pl.dart';
import 'locales/locale_vi.dart';
import 'locales/locale_zh.dart';
import 'locales/locale_zh_HK.dart';
import 'locales/locale_zh_TW.dart';

/// Map 形式的应用国际化配置，只聚合 `locales/` 目录下的语言文件。
abstract final class Translation {
  Translation._();

  static const fallbackLocale = Locale('zh', 'CN');

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('he'),
    Locale('ja'),
    Locale('pl'),
    Locale('vi'),
    Locale('zh', 'CN'),
    Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hans',
      countryCode: 'CN',
    ),
    Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'TW',
    ),
  ];

  static const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static final Map<String, Map<String, String>> translations = {
    'en': localeEn,
    'fr': localeFr,
    'he': localeHe,
    'ja': localeJa,
    'pl': localePl,
    'vi': localeVi,
    'zh_CN': localeZh,
    'zh_Hans_CN': localeZhHk,
    'zh_Hant_TW': localeZhTw,
  };

  /// 按 locale 查询 [key]；未找到时回退到中文简体，再回退 key 本身。
  static String tr(Locale locale, String key) {
    for (final localeKey in _localeCandidates(locale)) {
      final value = translations[localeKey]?[key];
      if (value != null) return value;
    }
    return translations['zh_CN']?[key] ?? key;
  }

  static Iterable<String> _localeCandidates(Locale locale) sync* {
    yield locale.toString();
    if (locale.scriptCode != null) {
      yield '${locale.languageCode}_${locale.scriptCode}';
    }
    if (locale.countryCode != null) {
      yield '${locale.languageCode}_${locale.countryCode}';
    }
    yield locale.languageCode;
    yield fallbackLocale.toString();
  }
}
