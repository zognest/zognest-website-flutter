import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';
import 'package:zognest_website/shared/widgets/social_button.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

class Footer extends StatelessWidget {
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
    return SizedBox(
      height: Responsive.isDesktop(context)
          ? 900
          : Responsive.isTablet(context)
              ? 700
              : 400,
      child: Stack(
        children: [
          GradientContainer(
            colorStartingOpacity: 0.2,
            color: theme.primaryColor,
            alignment: Alignment.bottomCenter,
            radius: 1,
            height: double.infinity,
          ),
          if (!Responsive.isDesktop(context))
            Positioned(
              right: Spacing.m16,
              top: Spacing.m16,
              child: CircleButton(
                onTap: widget.onTabUp,
                radius: Spacing.m16,
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
                      height: Spacing.m16,
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isDesktop(context)
                          ? Constants.webHorizontalPadding
                          : Constants.mobileHorizontalPadding,
                      vertical: Spacing.l24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ZognestLogo(
                          iconOnly: true,
                          size: Constants.zognestFooterSectionHeight * 0.15,
                        ),
                        const SizedBox(height: Spacing.s12),
                        FittedBox(
                          child: InkWell(
                            onTap: () {},
                            onHover: (over) {
                              setState(() => hovered = over);
                            },
                            overlayColor: const MaterialStatePropertyAll(
                                Palette.transparent),
                            child: Text(
                              Strings.zognestMail,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    Responsive.isDesktop(context) ? 70 : 20,
                                color: hovered
                                    ? theme.primaryColor
                                    : const Color(0xffAEB2BA),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Spacing.l24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  Strings.zognest.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displayLarge?.copyWith(
                                    fontFamily: 'SF Pro Rounded',
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -15,
                                  ),
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
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: SocialButtons.values
                                .map((button) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Responsive.isDesktop(context)
                                                ? Spacing.s8
                                                : Spacing.s4,
                                      ),
                                      child: SocialButton(button: button),
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: Spacing.l32),
                        FittedBox(
                          child: Text(
                            Strings.copyRights,
                            style: (Responsive.isDesktop(context)
                                    ? theme.textTheme.labelMedium
                                    : theme.textTheme.labelSmall)
                                ?.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
