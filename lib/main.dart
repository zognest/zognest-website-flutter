import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/firebase_options.dart';

import 'config/routes.dart';
import 'config/theme/custom_theme.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zognest',
      routerConfig: Routing.router,
      themeMode: ThemeMode.dark,
      darkTheme: CustomTheme.darkTheme(context),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
    );
  }
}
