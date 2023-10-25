import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({
    Key? key,
    this.onlyBody = false,
  }) : super(key: key);

  static const route = '/undefined-route';

  final bool onlyBody;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: onlyBody
          ? null
          : AppBar(
              title: const Text(Strings.routeNotFound),
              centerTitle: true,
              leading: const BackButton(),
            ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.routeNotFound,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: Spacing.l32),
            PrimaryButton(
              title: Strings.backHome,
              textStyle: theme.textTheme.labelLarge,
              padding: const EdgeInsets.all(Spacing.m20),
              onTap: () => context.goNamed(HomePage.route),
            ),
          ],
        ),
      ),
    );
  }
}
