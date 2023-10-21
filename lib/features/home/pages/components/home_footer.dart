import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  const HomeFooter({super.key, required this.onTabUp});

  final VoidCallback onTabUp;

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
                horizontal: Constants.pageHorizontalPadding,
                vertical: Spacing.l24,
              ),
              child: SizedBox(
                height: Constants.zognestFooterSectionHeight,
                child: Column(
                  children: [
                    const Spacer(),
                    const ZognestLogo(
                      iconOnly: true,
                      size: Constants.zognestFooterSectionHeight * 0.15,
                    ),
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
                    const Spacer(),
                    const SizedBox(width: Spacing.m20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          Strings.zognest.toUpperCase(),
                          textScaleFactor: TextThemes.textScale(context),
                          style: theme.textTheme.displayLarge?.copyWith(
                            letterSpacing: -10,
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: Spacing.m20),
                        CircleButton(
                          onTap: onTabUp,
                          radius: Spacing.l32,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: Constants.circleButtonRadius,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(height: Spacing.s8),
                              SvgPicture.asset(Assets.upArrow),
                            ],
                          ),
                        ),
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
                    const Spacer(),
                    const Text(Strings.copyRights),
                    const SizedBox(height: Spacing.s12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
