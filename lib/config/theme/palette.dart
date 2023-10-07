import 'package:flutter/material.dart';

abstract final class Palette {
  // Common
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;

  // Cases
  static const danger = Color(0xFFFF5252);
  static const ok = Color(0xFF4CAF50);
  static const neutral = Color(0xFF607D8B);

  // App
  static const primary = Color(0xffFFA100);
  static const scaffoldBackground = Palette.black;
  static const appBarBorder = Palette.white;
  static const appBarBackground = Color(0xff121212);
  static const secondaryGradient = Color(0xffD71040);
  static const primaryGradient = primary;
}
