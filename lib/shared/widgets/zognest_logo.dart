import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

class ZognestLogo extends StatelessWidget {
  const ZognestLogo({
    super.key,
    this.iconOnly = false,
  });

  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.zognestLogo),
        const SizedBox(width: Spacing.s4),
        if (!iconOnly) const ZognestText(),
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
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.primaryColor,
                  letterSpacing: 1.5,
                ),
              ),
              TextSpan(
                text: Strings.nest,
                style: theme.textTheme.labelLarge?.copyWith(letterSpacing: 1.5),
              ),
            ],
          ),
        ),
        Text(
          Strings.solutions,
          style:
              theme.textTheme.labelSmall?.copyWith(letterSpacing: 2, height: 1),
        ),
      ],
    );
  }
}
