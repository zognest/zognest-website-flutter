import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/strings.dart';

class OptimismText extends StatelessWidget {
  const OptimismText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: Constants.optimismSectionHeight,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.pageHorizontalPadding,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(Assets.mercuryVenus),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Text.rich(
                    textAlign: TextAlign.start,
                    textScaleFactor: TextThemes.textScale(context),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    TextSpan(
                      text: '${Strings.optimism.toUpperCase()}\n',
                      style: theme.textTheme.displayMedium,
                      children: [
                        TextSpan(
                          text: '${Strings.isThe.toUpperCase()}\n',
                          style: theme.textTheme.displayMedium
                              ?.copyWith(foreground: TextThemes.foreground),
                        ),
                        TextSpan(
                          text: Strings.faith.toUpperCase(),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.aboveBaseline,
                              baseline: TextBaseline.alphabetic,
                              child: Text(
                                Strings.nothingCanBeDone.toUpperCase(),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: theme.primaryColor,
                                  fontSize: 36,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Text.rich(
                    textAlign: TextAlign.end,
                    textScaleFactor: TextThemes.textScale(context),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    TextSpan(
                      text: '\t${Strings.that.toUpperCase()}\n',
                      style: theme.textTheme.displayMedium,
                      children: [
                        TextSpan(text: '${Strings.leadsTo.toUpperCase()}\n'),
                        TextSpan(text: Strings.achievement.toUpperCase()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
