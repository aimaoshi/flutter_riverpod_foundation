import 'package:flutter/material.dart';

/// Read-only layout metrics for the current widget tree.
///
/// Use [AppLayout.of] or [BuildContext.layout] inside a build method. Do not
/// retain this object outside the current build because window size, rotation,
/// and keyboard visibility can change its values.
@immutable
class AppLayout {
  const AppLayout._(this._mediaQuery);

  factory AppLayout.of(BuildContext context) {
    return AppLayout._(MediaQuery.of(context));
  }

  final MediaQueryData _mediaQuery;

  Size get screenSize => _mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  Orientation get orientation => _mediaQuery.orientation;

  /// System areas that content should normally avoid.
  EdgeInsets get safePadding => _mediaQuery.padding;

  /// Insets occupied by transient system UI, including the keyboard.
  EdgeInsets get viewInsets => _mediaQuery.viewInsets;

  double get statusBarHeight => safePadding.top;
  double get bottomSafeAreaHeight => safePadding.bottom;
  double get keyboardHeight => viewInsets.bottom;

  double get availableWidth =>
      screenWidth - safePadding.left - safePadding.right;

  double get availableHeight =>
      screenHeight - safePadding.top - safePadding.bottom - keyboardHeight;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isCompact => screenWidth < 600;
  bool get isTablet => screenWidth >= 600;

  /// Standard page padding for the Flutter Riverpod Foundation UI.
  EdgeInsets get pagePadding =>
      EdgeInsets.symmetric(horizontal: isCompact ? 24 : 40, vertical: 24);

  double widthFraction(double factor) => screenWidth * factor;
  double heightFraction(double factor) => screenHeight * factor;

  // Compatibility helpers for incremental migration from the existing app.
  double getScreenHeight() => screenHeight;
  double getScreenWidth() => screenWidth;

  /// Legacy code's calculation evaluates to [pixels], so preserve that result.
  double getHeight(double pixels) => pixels;
  double getWidth(double pixels) => pixels;

  /// The legacy name represents the top system inset.
  double getAppBarHeight() => statusBarHeight;

  /// The legacy name represents the bottom safe-area inset.
  double getStatusBarHeight() => bottomSafeAreaHeight;
}

extension AppLayoutContext on BuildContext {
  AppLayout get layout => AppLayout.of(this);
}
