import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';

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
                child: MobileAppBar()),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: AppBarButtons.values.map(
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
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
