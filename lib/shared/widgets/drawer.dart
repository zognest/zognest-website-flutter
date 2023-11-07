import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final route = GoRouterState.of(context);
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: AppBarButtons.values.map(
          (button) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Spacing.m16,
                horizontal: Spacing.s8,
              ),
              child: InkWell(
                onTap: () => context.go(button.route),
                overlayColor: MaterialStateProperty.all(Palette.transparent),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  child: Text(
                    button.title.toUpperCase(),
                    style: route.name == button.route
                        ? theme.textTheme.labelLarge
                            ?.copyWith(color: theme.primaryColor)
                        : theme.textTheme.labelMedium,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
