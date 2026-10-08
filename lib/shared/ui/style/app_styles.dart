import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

/////颜色命名规范
//   /* 1.文本颜色
//   2.常规大小 常规颜色
//   2.常规大小 （中） 常规颜色 （中）
//   3.加重颜色，加重大小
//   4.功能定义说明颜色
//   输入框颜色
//   1，大小，颜色*/
class AppStyles {
  static Color primaryColor = AppColors.primaryColor;
  static Color textSupayColorNormal = const Color(0xFF666666);
  static Color textSupayColorWeight = const Color(0xFF000000);
  static Color buttonSupayColor = Colors.blue;
  static TextStyle textStyleSupayNormal = TextStyle(
    fontSize: 14,
    color: new Color(0xFF666666),
    fontWeight: FontWeight.w500,
  );
  static TextStyle textStyleSupayWeight = TextStyle(
    fontSize: 14,
    color: new Color(0xFF000000),
    fontWeight: FontWeight.bold,
  );

  static TextStyle userManualTitleTextStyle = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16.sp,
  );

  static TextStyle userManualContentTextStyle = TextStyle(
    color: AppColors.textColor_lable,
    fontSize: 12.5.sp,
    height: 1.5,
  );

  static TextStyle popWindowsTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 12.5.sp,
  );

  static TextStyle gatewayTextStyle = TextStyle(
    color: AppColors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle addDeviceContentTextStyle = TextStyle(
    color: AppColors.TextbodyColor,
    fontSize: 12,
    height: 1.5,
  );
}
