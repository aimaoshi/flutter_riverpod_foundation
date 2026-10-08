import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/widgets.dart';

/// 尺寸
class AppSize {
  /// icon
  static double get icon => 18;

  /// 头像
  static double get avatar => 24;

  /// 旋转圆圈
  static double get indicator => 28;

  /// 旋转圆圈
  static double get titleBarHeight1 => 60.w;

  static double get titleBarHeight => 120.h;

  static double get titleBarTopHeight => 68.h;

  static double get popImageHeight => 20;
  static double get popImageWidth => 20;
  static double get popTextSize => 16;

  static double get gatewayTextSize => 14;

  static double get devicesDetailsImageHeight {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final h = view.physicalSize.height / view.devicePixelRatio;
    final ratio = h <= 667 ? 0.58 : (h <= 736 ? 0.55 : 0.5);
    return (h * ratio).clamp(380.0, h * 0.65);
  }

  /// 旋转圆圈
  static double get devicesDetailsContainerCircular => 360;

  static double get devicesDetailsContainerOpacity => 0.2;

  static double get devicesDetailsIconHeight => 80.w;
  static double get devicesDetailsIconWidth => 80.w;

  static double get devicesDetailsContainerHeight => 120.w;
  static double get devicesDetailsContainerWidth => 120.w;

  static double get deviceBottomHeight => 1.w;

  static double get deviceMiddleBottomHeight => 30.w;

  static double get homeTextSize => 12.0;

  static double get homeImageWidth => 25.w;

  static double get homeImageHeight => 25.w;

  static double get homeImageErrorWidth => 15.w;

  static double get homeImageErrorHeight => 15.w;

  static double get switchWidth => 50.w;

  static double get switchHeight => 150.w;
}
