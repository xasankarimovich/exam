import 'package:flutter/material.dart';

double width = 375;
double height = 812;

extension Size on num {
  SizedBox boxH() => SizedBox(height: (this / 812) * height);
  SizedBox boxW() => SizedBox(width: (this / 375) * width);
  double get h => (this / 812) * height;
  double get w => (this / 375) * width;
}

extension ContextExtension on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(this).viewPadding.top;
    double screenHeight =
        MediaQuery.of(this).size.height - appBarHeight - statusBarHeight;
    return screenHeight;
  }
}

