import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

class ScrollHeadline extends StatelessWidget {
  const ScrollHeadline({
    super.key,
    required this.headline,
    required this.onTapScroll,
  });

  final TextSpan headline;
  final VoidCallback? onTapScroll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context)
            ? Constants.webHorizontalPadding
            : Constants.mobileHorizontalPadding,
        vertical: Responsive.isDesktop(context) ? Spacing.l40 : Spacing.m16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(headline),
          if (onTapScroll != null) ...[
            InkWell(
              onTap: onTapScroll,
              overlayColor: MaterialStateProperty.all(Palette.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!Responsive.isMobile(context)) ...[
                    Column(
                      children: [
                        Text(
                          // textScaleFactor: TextThemes.textScale(context),
                          Strings.scroll.toUpperCase(),
                          style: theme.textTheme.displaySmall
                              ?.copyWith(fontSize: 54),
                        ),
                        Text(
                          // textScaleFactor: TextThemes.textScale(context),
                          Strings.toExploreMore.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: Spacing.l24),
                  ],
                  Image.asset(Assets.arrowRight, fit: BoxFit.cover),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
