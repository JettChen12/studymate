import 'package:flutter/material.dart';
import 'package:studymate/common_widget/count_down_timer.dart';

/// 圆形进度条
class TimerProgressIndicator extends StatefulWidget {
  final double width;
  final double height;
  final RemainSecondProvider remainSecondProvider;

  const TimerProgressIndicator({super.key, required this.width, required this.height, required this.remainSecondProvider});

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator> {
  double _progressValue = 1;

  @override
  void initState() {
    widget.remainSecondProvider.addListener(_update);
    super.initState();
  }

  @override
  void dispose() {
    widget.remainSecondProvider.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {
      _progressValue = widget.remainSecondProvider.value.remainSecondValue / widget.remainSecondProvider.value.totalValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: CircularProgressIndicator(
            value: _progressValue, strokeWidth: 12, backgroundColor: Colors.grey[300], valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)));
  }
}
