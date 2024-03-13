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
          AbsorbPointer(
            absorbing: true,
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              top: position.value.dy - 15,
              left: position.value.dx - 15,
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
              ),
            ),
          ),
          AbsorbPointer(
            absorbing: true,
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
              top: position.value.dy - 15,
              left: position.value.dx - 15,
              child: Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
