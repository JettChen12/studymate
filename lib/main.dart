import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/screen_util_helper.dart';
import 'pages/home.dart';

void main() => runApp(GetMaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SUtil.initWrapper(const Home());
  }
}
