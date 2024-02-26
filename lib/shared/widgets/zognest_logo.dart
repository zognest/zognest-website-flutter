import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

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
          Assets.zognestLogoPng,
          fit: BoxFit.cover,
          height: size ?? 50,
          width: size ?? 50,
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
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: Strings.zog,
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.primaryColor),
              ),
              TextSpan(
                text: Strings.nest,
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
        ),
        Text(
          Strings.solutions,
          style: theme.textTheme.labelMedium?.copyWith(height: 1),
        ),
      ],
    );
  }
}
