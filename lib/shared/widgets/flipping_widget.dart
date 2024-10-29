import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';

class FlippingWidget extends StatefulWidget {
  const FlippingWidget({
    super.key,
    required this.front,
    required this.back,
    this.curve,
    this.animationDuration,
  });

  final Widget front;
  final Widget back;
  final Duration? animationDuration;
  final Curve? curve;

  @override
  State<FlippingWidget> createState() => _FlippingWidgetState();
}

class _FlippingWidgetState extends State<FlippingWidget>
    with SingleTickerProviderStateMixin {
  bool _flip = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _flip = !_flip),
      onHover: (_) => setState(() => _flip = !_flip),
      overlayColor: WidgetStateProperty.all(Palette.transparent),
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        duration: widget.animationDuration ?? const Duration(milliseconds: 700),
        reverseDuration:
            widget.animationDuration ?? const Duration(milliseconds: 700),
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        transitionBuilder: (widget, animation) {
          final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotateAnim,
            child: widget,
            builder: (context, widget) {
              final isUnder = ValueKey(_flip) != widget?.key;
              double tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              final value =
                  isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: widget,
              );
            },
          );
        },
        child: _flip ? widget.back : AbsorbPointer(child: widget.front),
      ),
    );
  }
}
