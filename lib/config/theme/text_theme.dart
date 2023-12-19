import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zognest_website/config/responsive.dart';
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
    return size.width * 0.001;
  }

  static TextTheme textTheme(BuildContext context) {
    final theme = Theme.of(context);
    return TextTheme(
      // region Displays
      /// For headlines
      displaySmall: theme.textTheme.displaySmall?.copyWith(
        fontSize: Responsive.isDesktop(context) ? 120 : 64,
        height: 1,
        fontFamily: 'Oswald',
        fontVariations: fontVariation(7),
      ),

      /// All large displays except for ZOGNEST brand
      displayMedium: theme.textTheme.displayMedium?.copyWith(
        fontSize: 240,
        height: 1,
        fontFamily: 'Oswald',
        fontVariations: fontVariation(7),
      ),

      /// ZOGNEST brand
      displayLarge: theme.textTheme.displayLarge?.copyWith(
        fontSize: 320,
        height: 1,
        fontFamily: 'Oswald',
        fontVariations: fontVariation(7),
      ),
      // endregion
      // region Headlines
      headlineSmall: theme.textTheme.headlineSmall?.copyWith(
        fontFamily: 'Oswald',
        fontVariations: TextThemes.fontVariation(3),
        fontSize: 28,
        height: 1,
      ),
      headlineMedium: theme.textTheme.headlineMedium?.copyWith(
        fontFamily: 'Oswald',
        fontVariations: TextThemes.fontVariation(7),
        height: 1,
        fontSize: 38,
      ),
      headlineLarge: theme.textTheme.headlineLarge?.copyWith(
        fontFamily: 'SF Pro Rounded',
        fontWeight: FontWeight.w900,
        fontSize: 80,
      ),
      // endregion
      // region Body
      bodySmall: theme.textTheme.bodySmall?.copyWith(
        fontSize: 16,
        fontFamily: 'SF Pro Rounded',
        color: Palette.bodyTextColor,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 20,
        fontFamily: 'SF Pro Rounded',
        color: Palette.bodyTextColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: theme.textTheme.bodyLarge?.copyWith(
        fontSize: Responsive.isDesktop(context) ? 24 : 16,
        fontFamily: 'SF Pro Rounded',
        color: Palette.bodyTextColor,
        fontWeight: FontWeight.w500,
      ),
      // endregion
      // region Labels
      labelSmall: theme.textTheme.labelSmall?.copyWith(
        fontSize: 8,
        fontFamily: 'Oswald',
        fontWeight: FontWeight.w600,
      ),
      labelMedium: theme.textTheme.labelMedium?.copyWith(
        fontSize: 16,
        fontFamily: 'SF Pro Rounded',
        fontWeight: FontWeight.w600,
      ),
      labelLarge: theme.textTheme.labelLarge?.copyWith(
        fontSize: 18,
        fontFamily: 'SF Pro Rounded',
        fontWeight: FontWeight.w700,
      ),
      // endregion
    );
  }
}
