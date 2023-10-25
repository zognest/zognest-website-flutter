import 'package:flutter/material.dart';

class GreyscaleFilter extends StatelessWidget {
  const GreyscaleFilter({
    super.key,
    required this.isHovered,
    required this.child,
  });

  final bool isHovered;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ColorFiltered(
        colorFilter: isHovered
            ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
            : const ColorFilter.matrix(<double>[
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0,
                0,
                0,
                1,
                0
              ]),
        child: child,
      ),
    );
  }
}
