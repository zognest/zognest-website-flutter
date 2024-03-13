import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/theme/palette.dart';
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
        SvgPicture.network(
          Assets.zognestLogoSvg,
          fit: BoxFit.contain,
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
        Text(
          Strings.textZognest,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 44,
            color: Palette.primary,
            fontFamily: 'SF Pro Rounded',
          ),
        ),
      ],
    );
  }
}
