import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:studymate/global/navigator_item.dart';
import 'package:studymate/helper/screen_util_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 3;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageController, children: iconList.map((e) => e.page).toList()),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Color(0xff383A37),
        height: SUtil.height(60),
        icons: iconList.map((e) => e.icon).toList(),
        activeIndex: _currentIndex,
        leftCornerRadius: SUtil.height(32),
        rightCornerRadius: SUtil.height(32),
        gapLocation: GapLocation.none,
        activeColor: Colors.amber,
        inactiveColor: Colors.grey,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
        }),
      ),
    );
  }
}
