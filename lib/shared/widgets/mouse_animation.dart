import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedMouse extends HookWidget {
  const AnimatedMouse({super.key, required this.scaffold});

  final Scaffold scaffold;

  @override
  Widget build(BuildContext context) {
    final position = useState(const Offset(0, 0));
    return MouseRegion(
      onHover: (pointer) {
        position.value = pointer.position;
      },
      child: Stack(
        children: [
          scaffold,
          AnimatedPositioned(
            // TODO: Play with durations
            duration: const Duration(milliseconds: 500),
            // TODO: Play with curves
            // curve: ,
            // TODO: Play with values
            top: position.value.dy - 25,
            left: position.value.dx - 25,
            // TODO: Design widget
            child: const CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 16,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            // curve: ,
            top: position.value.dy - 25,
            left: position.value.dx - 25,
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 16,
            ),
          ),
        ],
      ),
    );
  }
}
