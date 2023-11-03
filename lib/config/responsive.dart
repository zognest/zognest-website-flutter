import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 720;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 720 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool appBar(BuildContext context) {
    return MediaQuery.of(context).size.width <= 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}
