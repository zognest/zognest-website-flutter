import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';

import '../../resources/spacing.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.filled = true,
    this.trailing,
    this.height,
    this.padding,
    this.width,
  });

  final String title;
  final double? height;
  final double? width;
  final bool filled;
  final Widget? trailing;
  final EdgeInsets? padding;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              filled ? theme.primaryColor : Palette.transparent),
          side: MaterialStateProperty.all(
            BorderSide(color: filled ? theme.primaryColor : Palette.white),
          ),
          padding: MaterialStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  horizontal: Spacing.s4,
                  vertical: Spacing.s12,
                ),
          ),
        ),
        child: Row(
          mainAxisAlignment: trailing != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (trailing != null) const SizedBox(width: Spacing.s8),
            Text(title, style: theme.textTheme.labelMedium),
            if (trailing != null) ...[
              const SizedBox(width: Spacing.s8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
