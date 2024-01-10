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
    this.textStyle,
    this.height,
    this.enabled = true,
    this.backgroundColor,
    this.padding,
    this.width,
  });

  final String title;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final bool filled;
  final bool enabled;
  final Color? backgroundColor;
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
        onPressed: enabled ? onTap : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            !enabled
                ? Palette.transparent
                : filled
                    ? backgroundColor ?? theme.primaryColor
                    : Palette.transparent,
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: !enabled
                  ? Palette.white
                  : filled
                      ? backgroundColor ?? theme.primaryColor
                      : Palette.white,
            ),
          ),
          padding: MaterialStateProperty.all(
            padding ??
                const EdgeInsets.symmetric(
                  horizontal: Spacing.s4,
                  vertical: Spacing.s12,
                ),
          ),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: trailing != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (trailing != null) const SizedBox(width: Spacing.s8),
              Text(title, style: textStyle ?? theme.textTheme.labelMedium),
              if (trailing != null) ...[
                const SizedBox(width: Spacing.s8),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
