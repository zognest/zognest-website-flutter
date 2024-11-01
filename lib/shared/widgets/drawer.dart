import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/widgets/contact_form.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/social_button.dart';

import '../../resources/assets.dart';
import '../../resources/strings.dart';
import 'circle_button.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final route = GoRouterState.of(context);
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ColoredBox(
        color: Palette.cardBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.s12,
                horizontal: Constants.mobileHorizontalPadding,
              ),
              child: MobileAppBar(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: Spacing.m20),
                ...AppBarButtons.values.map(
                  (button) {
                    return InkWell(
                      onTap: () => context.go(button.route),
                      overlayColor:
                          WidgetStateProperty.all(Palette.transparent),
                      child: Container(
                        color: route.name == button.route
                            ? theme.primaryColor
                            : Palette.transparent,
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.l32),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          button.title.toUpperCase(),
                          style: route.name == button.route
                              ? theme.textTheme.labelLarge
                                  ?.copyWith(color: Palette.black)
                              : theme.textTheme.labelMedium,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: Spacing.m20),
                Padding(
                  padding: const EdgeInsets.all(Spacing.s4),
                  child: Wrap(
                    runSpacing: Spacing.s8,
                    spacing: Spacing.s8,
                    children: SocialButtons.values
                        .map((button) => SocialButton(button: button))
                        .toList(),
                  ),
                ),
                const SizedBox(height: Spacing.m20),
                PrimaryButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Palette.cardBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Palette.dividerColor),
                          ),
                          child: SingleChildScrollView(
                            child: ContactForm(isDialog: true),
                          ),
                        ),
                      ),
                    );
                  },
                  height: 50,
                  width: 180,
                  title: Strings.getInTouch.toUpperCase(),
                  trailing: CircleButton(child: SvgPicture.asset(Assets.mail)),
                ),
                const SizedBox(height: Spacing.m20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
