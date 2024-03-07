import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
class PositionController extends ChangeNotifier {
  Offset _selectedPosition = Offset.zero;

  Offset get selectedPosition => _selectedPosition;

  void updateSelectedPosition(Offset position) {
    _selectedPosition = position;
    notifyListeners();
  }
}
class MouseRegion extends HookWidget {
  final PositionController positionController;

  const MouseRegion({super.key, required this.positionController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        positionController.updateSelectedPosition(details.localPosition);
      },
      child: Stack(
        children: [
          Positioned(
            left: positionController.selectedPosition.dx - 25,
            top: positionController.selectedPosition.dy - 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              'Selected Position: (${positionController.selectedPosition.dx.toInt()}, ${positionController.selectedPosition.dy.toInt()})',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}