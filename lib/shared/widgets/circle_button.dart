import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.child,
    this.onTap,
    this.radius,
    this.color
  });

  final Widget child;
  final double? radius;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStateProperty.all(Palette.transparent),
      child: CircleAvatar(
        radius: radius,
        foregroundColor: color,
        backgroundColor: Palette.white,
        child: child,
      ),
    );
  }
}
