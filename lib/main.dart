import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/firebase_options.dart';
import 'package:zognest_website/riverpod/controller.dart';

import 'config/routes.dart';
import 'config/theme/custom_theme.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appControllerProvider);
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
