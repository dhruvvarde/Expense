import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import '../constants/colors.dart';


class BarChart extends StatelessWidget {
  final double height;
  final String label;
  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 100;
  BarChart(this.height, this.label);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, child, animatedHeight) {
        return Column(
          children: <Widget>[
            Container(
              width: 12,
              height: (1 - animatedHeight) * _maxElementHeight,
              color: AppColors.lightBlue,
            ),
            Container(
              width: 12,
              height: animatedHeight * _maxElementHeight,
              color: AppColors.primaryColor,
            ),
            Text(label)
          ],
        );
      },
    );
  }
}