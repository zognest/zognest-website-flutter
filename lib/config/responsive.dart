import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 700 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool appBar(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static String deviceType(BuildContext context) {
    if (Responsive.isDesktop(context)) return 'Desktop';
    if (Responsive.isTablet(context)) return 'Tablet';
    return 'Mobile';
  }
}
