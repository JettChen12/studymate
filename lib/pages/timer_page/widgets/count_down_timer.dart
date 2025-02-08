import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  // 倒计时结束回调
  final VoidCallback onTimerFinished;

  // 倒计时控制器
  final TimerController timerController;

  // 提供当前剩余秒数
  final RemainSecondProvider? remainSecondProvider;

  const CountdownTimer({super.key, required this.onTimerFinished, required this.timerController, this.remainSecondProvider});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _remainingSeconds = 0; // 剩余秒数
  Timer? _timer; // 定时器
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timerController.second;
    widget.timerController.addListener(_listen);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // 销毁定时器
    _timer = null;
    _isRunning = false;
    widget.timerController.removeListener(_listen);
    super.dispose();
  }

  void _listen() {
    if (widget.timerController.isStop) {
      _stopTimer();
    } else if (widget.timerController.isPaused) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  /// 开始倒计时
  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    const oneSec = Duration(seconds: 1); // 1秒的间隔
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--; // 每秒减少剩余秒数
        } else {
          _timer?.cancel(); // 倒计时结束，取消定时器
          widget.onTimerFinished(); // 触发回调
        }
        // 把当前剩余值提供出去
        if (widget.remainSecondProvider != null) {
          widget.remainSecondProvider!
              ._notifyValue(RemainSecondValue(remainSecondValue: _remainingSeconds, totalValue: widget.timerController.second));
        }
      });
    });
  }

  /// 暂停倒计时
  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  } // 暂停定时器

  /// 结束倒计时
  void _stopTimer() {
    _timer?.cancel(); // 停止定时器
    _timer = null;
    _isRunning = false;
    setState(() {
      _remainingSeconds = 0; // 重置剩余秒数
    });
  }

  /// 转换显示格式
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formatTime(_remainingSeconds), // 显示剩余秒数
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

/// 倒计时控制器
class TimerController with ChangeNotifier {
  bool _isPaused = true;
  bool _isStop = true;
  int _second = 0;

  // 是否暂停
  bool get isPaused => _isPaused;

  // 是否结束
  bool get isStop => _isStop;

  // 时间
  int get second => _second;

  /// 设置时间
  void setTime(int second) {
    _second = second;
  }

  /// 开始
  void start() {
    if (!_isPaused && !_isStop) return;
    _isPaused = false;
    _isStop = false;
    notifyListeners();
  }

  /// 暂停
  void pause() {
    if (_isPaused) return;
    _isPaused = true;
    notifyListeners();
  }

  /// 结束
  /// 优先判定stop，再判定pause
  void stop() {
    if (_isStop) return;
    _isStop = true;
    _isPaused = true;
    notifyListeners();
  }
}

/// 剩余时间提供者
class RemainSecondProvider with ChangeNotifier {
  RemainSecondValue _value = RemainSecondValue(remainSecondValue: 0, totalValue: 0);

  RemainSecondValue get value => _value;

  void _notifyValue(RemainSecondValue value) {
    _value = value;
    notifyListeners();
  }
}

/// 倒计时器往外提供剩余时间的数值模型
class RemainSecondValue {
  // 剩余秒值
  final int remainSecondValue;

  // 总秒值
  final int totalValue;

  RemainSecondValue({required this.remainSecondValue, required this.totalValue});
}
