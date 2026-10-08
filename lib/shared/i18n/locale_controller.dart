import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() => null; // null 表示跟随系统语言

  void setLocale(Locale locale) {
    state = locale;
  }

  void followSystem() {
    state = null;
  }
}
