import 'dart:math';

import 'package:flutter/material.dart';

/// 旋转组件
class SpinWrapper extends StatefulWidget {
  const SpinWrapper({super.key, required this.controller, required this.child, required this.height, required this.width});

  // 动画控制器
  final AnimationController controller;

  // 被包裹的组件
  final Widget child;

  // 高
  final double height;

  // 宽
  final double width;

  @override
  State<SpinWrapper> createState() => _SpinWrapperState();
}

class _SpinWrapperState extends State<SpinWrapper> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 初始化AnimationController
    _controller = widget.controller;
    // 初始化Animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 使用Transform.rotate来实现旋转效果
          Transform.rotate(
            angle: _animation.value * 2 * pi, // 2 * pi = 360度
            child: SizedBox(width: widget.width, height: widget.height, child: widget.child),
          ),
        ],
      ),
    );
  }
}
