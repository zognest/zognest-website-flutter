import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/widgets/social_button.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key, required this.onTabUp});

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
          alignment: Alignment.bottomCenter,
          radius: 1,
          height: Responsive.isDesktop(context) ? 700 : 400,
        ),
        Column(
          children: [
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? Constants.webHorizontalPadding
                    : Constants.mobileHorizontalPadding,
                vertical: Spacing.l24,
              ),
              child: Column(
                children: [
                  const ZognestLogo(
                    iconOnly: true,
                    size: Constants.zognestFooterSectionHeight * 0.15,
                  ),
                  const SizedBox(height: Spacing.s12),
                  FittedBox(
                    child: Text(
                      Strings.zognestMail,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: Responsive.isDesktop(context) ? 70 : 20,
                        color: const Color(0xffAEB2BA),
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.l32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(
                          Strings.zognest.toUpperCase(),
                          textAlign: TextAlign.center,
                          textScaleFactor: TextThemes.textScale(context),
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      CircleButton(
                        onTap: onTabUp,
                        radius: Responsive.isDesktop(context)
                            ? Spacing.l32
                            : Spacing.l24,
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
                  const SizedBox(height: Spacing.l32),
                  Wrap(
                    spacing: Spacing.s12,
                    runSpacing: Spacing.s12,
                    children: SocialButtons.values
                        .map((button) => SocialButton(button: button))
                        .toList(),
                  ),
                  const SizedBox(height: Spacing.l48),
                  const FittedBox(child: Text(Strings.copyRights)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
