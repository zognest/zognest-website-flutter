import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'config/routes.dart';
import 'config/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zognest',
      theme: CustomTheme.darkTheme(context),
      routerConfig: Routing.router,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
    );
  }
}
