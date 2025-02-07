import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:studymate/helper/screen_util_helper.dart';

class AddTomatoDialog extends StatefulWidget {
  const AddTomatoDialog({super.key});

  @override
  State<AddTomatoDialog> createState() => _AddTomatoDialogState();
}

class _AddTomatoDialogState extends State<AddTomatoDialog> {
  // 选择的时间
  int _selectValue = 25;

  final List<String> data = List.generate(120, (index) => (index + 1).toString());
  final TextEditingController _controller = TextEditingController();

  List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }

  void _onSelect(String? value) {
    if (value != null) {
      _selectValue = int.tryParse(value) ?? 25;
    }
  }

  void _confirm() {
    if (_selectValue == 0) return;
    if (_controller.text.isEmpty) return;
    SmartDialog.dismiss(result: TomatoInfo(project: _controller.text, second: _selectValue * 60));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SUtil.height(300),
        width: SUtil.width(300),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: SUtil.height(25),
            width: SUtil.width(100),
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.only(bottomRight: Radius.circular(SUtil.sp(10)))),
            child: Center(child: Text('学习时间', style: TextStyle(fontSize: SUtil.sp(12), color: Colors.black, fontWeight: FontWeight.w600))),
          ),
          SizedBox(height: SUtil.height(20)),

          /// 挑选时间
          Center(
            child: DropdownMenu<String>(
              label: Text('分钟', style: TextStyle(fontSize: SUtil.sp(15), color: Colors.black, fontWeight: FontWeight.w600)),
              leadingIcon: SizedBox(width: SUtil.width(15)),
              menuHeight: 200,
              initialSelection: data[24],
              onSelected: _onSelect,
              dropdownMenuEntries: _buildMenuList(data),
              textStyle: TextStyle(fontSize: SUtil.sp(25), color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: SUtil.height(20)),

          Container(
            height: SUtil.height(25),
            width: SUtil.width(100),
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.only(bottomRight: Radius.circular(SUtil.sp(10)))),
            child: Center(child: Text('学习内容', style: TextStyle(fontSize: SUtil.sp(12), color: Colors.black, fontWeight: FontWeight.w600))),
          ),
          SizedBox(height: SUtil.height(20)),

          /// 内容
          Center(
            child: SizedBox(
              height: SUtil.height(45),
              width: SUtil.width(120),
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(SUtil.sp(8)), border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SUtil.sp(15), color: Colors.black, fontWeight: FontWeight.w600),
                maxLength: 6,
              ),
            ),
          ),

          SizedBox(height: SUtil.height(20)),

          /// 确认
          Center(
            child: GestureDetector(
              onTap: () => _confirm(),
              child: Container(
                height: SUtil.height(35),
                width: SUtil.width(100),
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(SUtil.sp(8))),
                child: Center(child: Text('确认', style: TextStyle(color: Colors.black, fontSize: SUtil.sp(15), fontWeight: FontWeight.w600))),
              ),
            ),
          )
        ]));
  }
}

/// 用户填写的番茄钟信息
class TomatoInfo {
  final String project;
  final int second;

  TomatoInfo({required this.project, required this.second});
}
