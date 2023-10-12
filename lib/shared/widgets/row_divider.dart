import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/resources/spacing.dart';

class RowDivider extends StatelessWidget {
  const RowDivider({super.key, this.height, this.width, this.color});

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l40),
      child: Container(
        height: height ?? Constants.countItemHeight,
        width: width ?? 0.5,
        color: color ?? theme.primaryColor,
      ),
    );
  }
}
