import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/widgets/social_button.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GradientContainer(
          colorStartingOpacity: 0.2,
          color: theme.primaryColor,
          alignment: const Alignment(-0.2, 1),
          radius: 0.9,
          height: 700,
        ),
        GradientContainer(
          colorStartingOpacity: 0.2,
          color: theme.primaryColor,
          alignment: const Alignment(0.2, 1),
          radius: 0.9,
          height: 700,
        ),
        Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.webHorizontalPadding,
                vertical: Spacing.xl64,
              ),
              child: Column(
                children: [
                  const ZognestLogo(iconOnly: true),
                  const SizedBox(width: Spacing.m20),
                  Text(
                    Strings.zognestMail,
                    textScaleFactor: TextThemes.textScale(context),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 70,
                      color: const Color(0xffAEB2BA),
                    ),
                  ),
                  const SizedBox(width: Spacing.m20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.zognest.toUpperCase(),
                        textScaleFactor: TextThemes.textScale(context),
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: Spacing.m20),
                      const CircleButton(asset: Assets.upArrow),
                    ],
                  ),
                  const SizedBox(width: Spacing.m20),
                  Wrap(
                    spacing: Spacing.s12,
                    runSpacing: Spacing.s12,
                    children: SocialButtons.values
                        .map((button) => SocialButton(button: button))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
