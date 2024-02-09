import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/social_button.dart';

import '../../resources/assets.dart';
import '../../resources/strings.dart';
import 'circle_button.dart';
import 'contact_form_appbar.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                const SizedBox(height:Spacing.m20),
                ...AppBarButtons.values.map(
                  (button) {
                    return InkWell(
                      onTap: () => context.go(button.route),
                      overlayColor:
                          MaterialStateProperty.all(Palette.transparent),
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
                      builder: (context) => Material(
                          child:ContactFormAppBar(key:formKey,)
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
