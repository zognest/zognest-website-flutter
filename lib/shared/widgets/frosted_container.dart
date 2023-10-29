import 'dart:ui';

import 'package:flutter/material.dart';

import '../../config/theme/palette.dart';

class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    Key? key,
    required this.child,
    this.blurStrength = 24,
    this.backgroundColor = Palette.cardBackgroundColor,
    this.borderRadius,
    this.width,
    this.padding,
    this.height,
    this.decoration,
    this.borderRadiusGeometry,
  }) : super(key: key);

  final Widget child;
  final double blurStrength;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Decoration? decoration;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurStrength,
          sigmaY: blurStrength,
        ),
        child: Container(
          color: decoration != null ? null : backgroundColor,
          padding: padding,
          height: height,
          decoration: decoration,
          width: width,
          child: child,
        ),
      ),
    );
  }
}
