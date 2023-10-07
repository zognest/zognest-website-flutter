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
  });

  final String title;
  final bool filled;
  final Widget? trailing;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(Palette.transparent),
      child: Container(
        height: Spacing.xl60,
        padding: EdgeInsets.only(
          top: Spacing.s4,
          bottom: Spacing.s4,
          right: trailing != null ? Spacing.s4 : Spacing.m16,
          left: Spacing.m16,
        ),
        decoration: ShapeDecoration(
          color: filled ? theme.primaryColor : Palette.transparent,
          shape: StadiumBorder(
            side: BorderSide(
              color: filled ? Palette.transparent : Palette.white,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.labelMedium),
            const SizedBox(width: Spacing.s8),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
