import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  // static const double _thumbSize = 10.0; // 滑块大小
  // static const double _disabledThumbSize = 10.0; // 禁用时滑块大小

  final Color bgColor;
  final Color centerColor;
  final double _thumbSize;

  CustomThumbShape(this.bgColor, this.centerColor, this._thumbSize); // final

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? Size.fromRadius(_thumbSize)
        : Size.fromRadius(_thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    // final ColorTween colorTween = ColorTween(
    //     begin: Colors.blue, end: Colors.white); // 颜色渐变示例，可根据需要调整或删除此行代码以使用固定颜色。
    // final Color color = colorTween.evaluate(enableAnimation)!; // 使用渐变颜色或固定颜色。
    // final Radius radius = Radius.circular(2); // 滑块圆角半径。可以根据需要调整圆角大小。
    // final Paint paint = Paint()..color = color; // 使用上面定义的渐变或固定颜色。

    final Offset canvasCenter = Offset(
      center.dx - _thumbSize / 2,
      center.dy - _thumbSize / 2,
    ); // 调整画布中心以适应滑块大小。
    // canvas.drawRRect(
    //     RRect.fromRectAndRadius(
    //         Rect.fromCenter(
    //             center: canvasCenter + Offset(_thumbSize / 2, _thumbSize / 2),
    //             width: 8,
    //             height: 17),
    //         radius),
    //     paint);

    // double _thumbSize1 = 8.0; // 滑块大小

    // final ColorTween colorTween1 = ColorTween(
    //     begin: Colors.blue, end: Colors.green); // 颜色渐变示例，可根据需要调整或删除此行代码以使用固定颜色。
    // final Color color1 = colorTween1.evaluate(enableAnimation)!; // 使用渐变颜色或固定颜色。
    // final Radius radius1 = Radius.circular(2); // 滑块圆角半径。可以根据需要调整圆角大小。
    // final Paint paint1 = Paint()..color = color1; // 使用上面定义的渐变或固定颜色。
    // final Offset canvasCenter1 = Offset(center.dx - _thumbSize1 / 4,
    //     center.dy - _thumbSize1 / 4); // 调整画布中心以适应滑块大小。
    // canvas.drawRRect(
    //     RRect.fromRectAndRadius(
    //         Rect.fromCenter(
    //             center:
    //                 canvasCenter1 + Offset(_thumbSize1 / 4, _thumbSize1 / 4),
    //             width: 8,
    //             height: 17),
    //         radius1),
    //     paint1);

    // 使用RRect绘制圆角矩形滑块。

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: canvasCenter + Offset(_thumbSize * 1, _thumbSize / 2),
          // 直接居中
          width: _thumbSize * 1.5,
          height: _thumbSize * 3,
        ),
        Radius.circular(4), // 圆角 10
      ),
      Paint()..color = bgColor, // 红色填充
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: canvasCenter + Offset(_thumbSize * 1, _thumbSize / 2),
          // 直接居中
          width: _thumbSize * 0.5,
          height: _thumbSize * 1.5,
        ),
        Radius.circular(4), // 圆角 10
      ),
      Paint()..color = centerColor, // 红色填充
    );
  }
}
