import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../common_widget/add_tomato_dialog.dart';
import '../../common_widget/count_down_timer.dart';
import '../../common_widget/progress_indicator.dart';
import '../../common_widget/spin_wrapper.dart';
import '../../helper/screen_util_helper.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _spinController;
  final TimerController _timerController = TimerController();
  final RemainSecondProvider _remainSecondProvider = RemainSecondProvider();

  // 是否正在沉浸
  bool _isRunning = false;

  // 是否暂停
  bool _isPause = false;

  // 当前正在沉浸的项目
  String _project = '';

  void _listen() {
    if (mounted) {
      setState(() {
        _isPause = _timerController.isPaused;
      });
    }
    if (!_timerController.isPaused && !_timerController.isStop) {
      _spinController.forward();
      _spinController.repeat();
    } else {
      _spinController.stop();
    }
  }

  void _show() async {
    final TomatoInfo? result = await SmartDialog.show(builder: (context) => AddTomatoDialog());
    if (result != null) {
      // 切换模式
      _isRunning = true;
      // 开启转盘
      _spinController.reset();
      _spinController.forward();
      _spinController.repeat();
      // 开启倒计时
      _timerController.setTime(result.second);
      _timerController.start();
      // 修改标题
      setState(() {
        _project = result.project;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(duration: Duration(seconds: 8), vsync: this);
    _spinController.forward();
    _spinController.repeat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timerController.addListener(_listen);
    });
  }

  @override
  void dispose() {
    _spinController.dispose();
    _timerController.removeListener(_listen);
    _timerController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            height: SUtil.height(30),
            width: SUtil.width(100),
            child: Center(
                child: Text(
              _isRunning ? _project : '沉浸学习',
              style: TextStyle(fontSize: SUtil.sp(18), fontWeight: FontWeight.bold, color: Colors.black),
            )),
          ),
          centerTitle: true,
          actions: [Icon(Icons.menu), SizedBox(width: SUtil.width(20))],
        ),
        body: _isRunning
            ? Column(
                children: [
                  /// 转盘
                  SizedBox(height: SUtil.height(30)),
                  Stack(
                    children: [
                      SizedBox(
                          height: SUtil.height(280),
                          child: SpinWrapper(
                            controller: _spinController,
                            height: SUtil.height(280),
                            width: SUtil.width(280),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: AssetImage('assets/default_spin.png'), fit: BoxFit.fill),
                              ),
                              // 内组件
                              child: Center(),
                            ),
                          )),
                      // 圆形进度条
                      Center(
                        child:
                            TimerProgressIndicator(width: SUtil.width(280), height: SUtil.height(280), remainSecondProvider: _remainSecondProvider),
                      ),
                    ],
                  ),

                  SizedBox(height: SUtil.height(40)),

                  /// 显示时间
                  CountdownTimer(
                    onTimerFinished: () {
                      print('finished');
                    },
                    timerController: _timerController,
                    remainSecondProvider: _remainSecondProvider,
                  ),
                  SizedBox(height: SUtil.height(50)),

                  /// 暂停按钮

                  if (!_isPause)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _timerController.pause();
                      },
                      child: Container(
                          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.height(20))),
                          width: SUtil.width(60),
                          height: SUtil.height(60),
                          child: Icon(Icons.pause)),
                    ),

                  if (_isPause)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _timerController.start();
                          },
                          child: Container(
                              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.height(20))),
                              width: SUtil.width(60),
                              height: SUtil.height(60),
                              child: Icon(Icons.play_arrow)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: SUtil.width(20)),
                          child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _timerController.stop();
                              },
                              child: Container(
                                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.height(20))),
                                  width: SUtil.width(60),
                                  height: SUtil.height(60),
                                  child: Icon(Icons.stop))),
                        ),
                      ],
                    ),
                ],
              )
            : Center(
                child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _show(),
                child: Container(
                  height: SUtil.height(40),
                  width: SUtil.width(120),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.height(10))),
                  child: Padding(
                    padding: EdgeInsets.all(SUtil.sp(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('开始沉浸', style: TextStyle(fontSize: SUtil.sp(15), color: Colors.black, fontWeight: FontWeight.w600)),
                        SizedBox(width: SUtil.width(5)),
                        Icon(Icons.add_circle_outline)
                      ],
                    ),
                  ),
                ),
              )));
  }

  @override
  bool get wantKeepAlive => true;
}
