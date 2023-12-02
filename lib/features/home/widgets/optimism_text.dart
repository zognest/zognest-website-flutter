import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

class OptimismText extends StatelessWidget {
  const OptimismText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const Divider(),
        // const SizedBox(height: Constants.webVerticalPadding * 0.7),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)
                ? Constants.webHorizontalPadding
                : Constants.mobileHorizontalPadding,
          ),
          child: SizedBox(
            height: Responsive.isDesktop(context)
                ? Constants.optimismSectionHeight
                : 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(Assets.mercuryVenus, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: Constants.optimismSectionHeight,
                    width: size.width * 0.5,
                    child: FittedBox(
                      child: Text.rich(
                        textAlign: TextAlign.start,
                        maxLines: 3,
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
                                  baseline: TextBaseline.alphabetic,
                                  alignment: PlaceholderAlignment.middle,
                                  child: Column(
                                    children: [
                                      Text(
                                        Strings.nothingCanBeDone.toUpperCase(),
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          color: theme.primaryColor,
                                          fontSize: 36,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(height: Spacing.l32),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: Constants.optimismSectionHeight,
                    width: size.width * 0.55,
                    child: FittedBox(
                      child: Text.rich(
                        textAlign: TextAlign.end,
                        maxLines: 3,
                        TextSpan(
                          text: '\t${Strings.that.toUpperCase()}\n',
                          style: theme.textTheme.displayMedium,
                          children: [
                            TextSpan(
                                text: '${Strings.leadsTo.toUpperCase()}\n'),
                            TextSpan(text: Strings.achievement.toUpperCase()),
                          ],
                        ),
                      ),
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
