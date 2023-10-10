import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/text_theme.dart';

import 'palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Palette.primary,
      scaffoldBackgroundColor: Palette.scaffoldBackground,
      dividerTheme: const DividerThemeData(space: 1),
      textTheme: TextThemes.textTheme(context).apply(
        bodyColor: Palette.white,
        displayColor: Palette.white,
      ),
    );
  }
}
