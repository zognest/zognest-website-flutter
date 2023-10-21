import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.child,
    this.onTap,
    this.radius,
  });

  final Widget child;
  final double? radius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(Palette.transparent),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Palette.white,
        child: child,
      ),
    );
  }
}
