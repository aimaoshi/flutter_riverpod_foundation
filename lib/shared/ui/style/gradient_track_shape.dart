import 'package:flutter/material.dart';

class GradientTrackShape extends SliderTrackShape {
  final double borderRadius;
  final List<Color> gradientColors;

  const GradientTrackShape({
    this.borderRadius = 8,
    this.gradientColors = const [Colors.blue, Colors.green],
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    // 修复1：正确计算轨道垂直位置
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(offset.dx, trackTop, trackWidth, trackHeight);
  }

  // PaintingContext context,
  //     Offset offset, {
  // required RenderBox parentBox,
  // required SliderThemeData sliderTheme,
  // required Animation<double> enableAnimation,
  // required Offset thumbCenter,
  // Offset? secondaryOffset,
  // bool isEnabled,
  // bool isDiscrete,
  // required TextDirection textDirection,

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );
    // 1. 绘制整个渐变色背景（圆角矩形）
    final gradientPaint = Paint()
      ..shader = LinearGradient(colors: gradientColors).createShader(trackRect)
      ..style = PaintingStyle.fill;

    // 先绘制完整渐变背景
    canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(borderRadius)),
      gradientPaint,
    );

    // 修复3：修正未激活区域计算
    if (thumbCenter.dx >= trackRect.left) {
      //1  thumbCenter.dx 2.3974609374999516   trackRect.left 0.0
      //thumbCenter.dx 0.06217447916668427   trackRect.left 0.0

      //Log().i("${TAG} 范围值   thumbCenter.dx ${thumbCenter.dx}   trackRect.left ${trackRect.left}");

      final inactivePaint = Paint()
        ..color = sliderTheme.inactiveTrackColor!
        ..style = PaintingStyle.fill;

      final inactiveRect = Rect.fromLTRB(
        thumbCenter.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
      );

      // Log().i("${TAG} inactiveRect ${inactiveRect.toString()}");

      // 99 (226.0, 0.0, 226.0, 20.0)
      //0(0.1, 0.0, 226.0, 20.0)
      // 强制绘制未激活区域
      canvas.drawRRect(
        RRect.fromRectAndRadius(inactiveRect, Radius.circular(borderRadius)),
        inactivePaint,
      );
    }
  }
}
