import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
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
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? Spacing.l40 : Spacing.s12,
      ),
      child: Container(
        height: height ??
            (Responsive.isDesktop(context)
                ? Constants.webCountItemHeight
                : Constants.mobileCountItemHeight),
        width: width ?? 0.5,
        color: color ?? theme.primaryColor,
      ),
    );
  }
}
