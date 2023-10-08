import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.color,
    this.alignment,
    this.height,
    this.width,
    this.child,
    this.radius = 0.6,
    this.secondaryColor,
  });

  final Color color;
  final Alignment? alignment;
  final double radius;
  final double? height;
  final double? width;
  final Color? secondaryColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: alignment ?? Alignment.center,
              radius: radius,
              colors: [color.withOpacity(0.5), color.withOpacity(0)],
            ),
          ),
          child: child,
        ),
        if (secondaryColor != null)
          GradientContainer(
            color: secondaryColor!,
            alignment: alignment,
            radius: radius,
            height: height,
            width: width,
          ),
      ],
    );
  }
}
