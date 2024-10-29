import 'package:flutter/material.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';

class ZognestLogo extends StatelessWidget {
  const ZognestLogo({
    super.key,
    this.iconOnly = false,
    this.size,
  });

  final bool iconOnly;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.zognestLogoNew,
          fit: BoxFit.contain,
          height: size,
          width: size,
        ),
        if (!iconOnly) ...[
          const SizedBox(width: Spacing.s4),
          const ZognestText(),
        ],
      ],
    );
  }
}

class ZognestText extends StatelessWidget {
  const ZognestText({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.zognestText, fit: BoxFit.contain, width: 300);
  }
}
