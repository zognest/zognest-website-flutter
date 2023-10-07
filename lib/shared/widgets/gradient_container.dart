import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.color,
    required this.alignment,
    this.radius = 0.7,
    this.overlap = false,
    this.secondaryColor,
  });

  final Color color;
  final Alignment alignment;
  final double radius;
  final bool overlap;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: alignment,
              radius: radius,
              colors: [color.withOpacity(0.5), color.withOpacity(0)],
            ),
          ),
        ),
        if (overlap)
          GradientContainer(
            color: secondaryColor!,
            alignment: alignment,
            radius: radius,
          ),
      ],
    );
  }
}
