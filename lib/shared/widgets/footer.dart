import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/social_button.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

class Footer extends StatefulWidget {
  const Footer({super.key, required this.onTabUp});

  final VoidCallback onTabUp;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.bottomCenter,
          radius: 1,
          colors: [
            theme.primaryColor.withOpacity(0.2),
            theme.primaryColor.withOpacity(0),
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalPadding,
                    vertical: Spacing.l24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  ZognestLogo(
                    iconOnly: true,
                    size: Responsive.isDesktop(context)?80:40,
                  ),
                  const SizedBox(height: Spacing.s12),
                  InkWell(
                    onTap: () {},
                    onHover: (over) {
                      setState(() => hovered = over);
                    },
                    overlayColor:
                    const MaterialStatePropertyAll(Palette.transparent),
                    child: Text(
                      Strings.zognestMail,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: Responsive.isDesktop(context) ? 70 : 20,
                        color: hovered
                            ? theme.primaryColor
                            : const Color(0xffAEB2BA),
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.l24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          Strings.zognest.toUpperCase(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      if (Responsive.isDesktop(context))
                        CircleButton(
                          onTap: widget.onTabUp,
                          radius: Responsive.isDesktop(context)
                              ? Spacing.l32
                              : Spacing.m16,
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
                              const SizedBox(height: Spacing.s4),
                              SvgPicture.asset(
                                Assets.upArrow,
                                height: Responsive.isDesktop(context)
                                    ? Spacing.m20
                                    : Spacing.s12,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Spacing.l24),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: SocialButtons.values
                        .map((button) => SocialButton(button: button))
                        .toList(),
                  ),
                  const SizedBox(height: Spacing.l24),
                  Text(
                    Strings.copyRights,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.isDesktop(context)?16:10
                    ),
                  ),
                ],
                ),
                ),
              ],
            ),
          ),
          if (!Responsive.isDesktop(context)) ...[
            Positioned(
              right: Spacing.l32,
              top: 0,
              child: CircleButton(
                onTap: widget.onTabUp,
                radius: Spacing.l32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Spacing.s4,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: Spacing.s4),
                    SvgPicture.asset(
                      Assets.upArrow,
                      height: Spacing.m20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
