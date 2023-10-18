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
      mainAxisAlignment: MainAxisAlignment.center,
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
