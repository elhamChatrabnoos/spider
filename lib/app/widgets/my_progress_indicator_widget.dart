import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key, this.color, this.indicatorType});
  final Color? color;
  final Indicator? indicatorType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Center(
        child: LoadingIndicator(
          colors: color == null ? null : [color!],
          indicatorType: indicatorType ?? Indicator.lineScale,
        ),
      ),
    );
  }
}
