import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedImage extends HookWidget {
  const AnimatedImage({
    super.key,
    required this.child,
    this.length = 1,
    this.index = 0,
  });

  final int length;
  final int index;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: const Duration(seconds: 1));
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.5) animationController.forward();
      },
      key: ValueKey('${runtimeType.toString()}$index$length'),
      child: AnimatedListItem(
        length: length,
        index: index,
        aniController: animationController,
        animationType: AnimationType.fade,
        child: child,
      ),
    );
  }
}
