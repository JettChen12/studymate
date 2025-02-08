import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../helper/screen_util_helper.dart';

/// 番茄钟时间到弹的dialog
class TomatoTimeOutDialog extends StatelessWidget {
  const TomatoTimeOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SUtil.height(200),
      width: SUtil.width(300),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 当前学习时间到了，请休息一下
          Container(
            padding: EdgeInsets.only(top: SUtil.height(10)),
            child: Center(child: Text('温馨提示', style: TextStyle(fontSize: SUtil.sp(20), color: Colors.black, fontWeight: FontWeight.w600))),
          ),
          SizedBox(height: SUtil.height(30)),
          Center(
            child: Text('当前学习时间到了', style: TextStyle(fontSize: SUtil.sp(25), color: Colors.black, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: SUtil.height(30)),
          Center(
              child: GestureDetector(
                  onTap: () => SmartDialog.dismiss(),
                  child: Container(
                    height: SUtil.height(35),
                    width: SUtil.width(100),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.sp(8))),
                    child: Center(child: Text('确定', style: TextStyle(color: Colors.black, fontSize: SUtil.sp(15), fontWeight: FontWeight.w600))),
                  )))
        ],
      ),
    );
  }
}
