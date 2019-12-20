import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///time:  2019/12/20
///author: wangbufan
///email: wangbufan00@gmail.com
///

class Indicator extends StatelessWidget {
  Indicator({this.itemChosen=0, this.itemCount = 0});

  /// 指示器的个数
  final int itemChosen;
  /// 指示器的个数
  final int itemCount;

  /// 普通的颜色
  final Color normalColor = Colors.grey[100];

  /// 选中的颜色
  final Color selectedColor = Colors.black;

  /// 点的大小
  final double size = 8.0;

  /// 点的间距
  final double spacing = 4.0;

  Widget _buildIndicator(int index) {
    bool isCurrentPageSelected = index ==itemChosen%itemCount;

    return Container(
      height: size,
      width: size + 2 * spacing,
      child: Center(
        child: Material(
          color: isCurrentPageSelected ? selectedColor : normalColor,
          type: MaterialType.circle,
          child: Container(
            height: size,
            width: size,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (index) {
        return _buildIndicator(index);
      }),
    );
  }
}
