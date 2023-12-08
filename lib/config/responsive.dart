import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 600 &&
        MediaQuery.sizeOf(context).width < 1000;
  }

  static bool appBar(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1000;
  }

  static String deviceType(BuildContext context) {
    if (Responsive.isDesktop(context)) return 'Desktop';
    if (Responsive.isTablet(context)) return 'Tablet';
    return 'Mobile';
  }
}
