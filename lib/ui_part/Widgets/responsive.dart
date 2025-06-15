import 'package:flutter/widgets.dart';

class Responsive {
  static double sizeW(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double baselineWidth = 375;
    return size * (screenWidth / baselineWidth);
  }
  static double sizeH(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.height;
    const double baselineWidth = 849;
    return size * (screenWidth / baselineWidth);
  }
}