import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 自适应屏幕帮助方法
///
abstract class SUtil {
  /// 初始化
  static Widget initWrapper(Widget childWidget) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
            theme: ThemeData(primarySwatch: Colors.blue, textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp)),
            home: child);
      },
      child: childWidget,
    );
  }

  /// 设置高
  static double height(double height) => ScreenUtil().setHeight(height);

  /// 设置宽
  static double width(double width) => ScreenUtil().setWidth(width);

  /// 设置字体
  static double sp(double sp) => ScreenUtil().setSp(sp);
}
