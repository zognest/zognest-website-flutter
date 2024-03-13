import 'package:flutter/material.dart';

class FloatingIcon extends StatefulWidget {
  const FloatingIcon({
    super.key,
    required this.assets,
    this.width,
    required this.alignment,
    this.positionAnimation,
    required this.isHorizontal,
  });

  final String assets;
  final double? width;
  final AlignmentGeometry alignment;
  final Animation<Offset>? positionAnimation;
  final bool isHorizontal;

  @override
  State<FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<FloatingIcon>
    with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: widget.isHorizontal
          ? const Offset(-0.4, 0.0)
          : const Offset(0.0, -0.03),
      end: widget.isHorizontal
          ? const Offset(0.1, 0.0)
          : const Offset(0.0, 0.03),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.positionAnimation ?? _offsetAnimation,
      child: Image.asset(
        widget.assets,
        width: widget.width,
        alignment: widget.alignment,
      ),
    );
  }
}
