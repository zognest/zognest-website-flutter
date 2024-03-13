import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

class ScrollHeadline extends HookWidget {
   const ScrollHeadline({
    super.key,
    required this.headline,
    required this.onTapScroll,
  });

  final TextSpan headline;
  final VoidCallback? onTapScroll;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> animation=useState(false);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
        vertical: Responsive.isDesktop(context) ? Spacing.l40 : Spacing.m16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          VisibilityDetector(
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 1) {
                  animation.value=true;
                }else if(info.visibleFraction==0){
                  animation.value=false;
                }
              },
              key: ValueKey(runtimeType.toString()),
              child: AnimatedOpacity(
                  opacity: animation.value ? 1:0.5 ,
                  duration: const Duration(milliseconds: 200),
                  child: Text.rich(headline))),
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
