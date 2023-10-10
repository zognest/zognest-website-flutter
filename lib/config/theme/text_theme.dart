import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';

abstract final class TextThemes {
  static List<FontVariation> fontVariation(int weight) =>
      [FontVariation('wght', weight * 100)];

  /// Used to outline text
  static final foreground = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = Palette.white;

  static double textScale(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width * 0.0004;
  }

  static TextTheme textTheme(BuildContext context) {
    final theme = Theme.of(context);
    return TextTheme(
      // Display
      displaySmall: theme.textTheme.displaySmall?.copyWith(
        fontSize: 120,
        height: 1,
        fontVariations: fontVariation(3),
      ),
      displayMedium: theme.textTheme.displayMedium?.copyWith(
        fontSize: 260,
        height: 1,
        fontVariations: fontVariation(7),
      ),
      displayLarge: theme.textTheme.displayLarge?.copyWith(
        fontSize: 320,
        height: 1,
        fontVariations: fontVariation(7),
      ),
      // Body
      bodyLarge: theme.textTheme.bodyLarge?.copyWith(
        fontSize: 24,
        height: 1,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      // Label
      labelSmall: theme.textTheme.labelSmall?.copyWith(
        fontSize: 14,
        height: 1,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      labelMedium: theme.textTheme.labelMedium?.copyWith(
        fontSize: 16,
        height: 1,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      labelLarge: theme.textTheme.labelLarge?.copyWith(
        fontSize: 18,
        height: 1,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
