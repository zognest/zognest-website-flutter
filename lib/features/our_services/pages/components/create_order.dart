import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/strings.dart';

class CreateOrder extends StatelessWidget {
  const CreateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const Divider(),
        SizedBox(
          width: double.infinity,
          height: 2500,
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(-0.85, 1),
                heightFactor: 1.2,
                child: Image.asset(
                  Assets.smallMercury,
                  fit: BoxFit.cover,
                  width: size.width * 0.15,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  Assets.moon,
                  width: size.width * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Constants.componentVerticalPadding,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    child: Text.rich(
                      textAlign: TextAlign.right,
                      TextSpan(
                        text: Strings.empty,
                        style: theme.textTheme.displayLarge,
                        children: [
                          TextSpan(
                            text: Strings.what.toUpperCase(),
                            style: theme.textTheme.displayLarge?.copyWith(
                              foreground: TextThemes.foreground,
                            ),
                          ),
                          TextSpan(
                            text: Strings.areYouWaitingFor.toUpperCase(),
                            style: theme.textTheme.displayLarge,
                          ),
                          TextSpan(
                            text: '\t${Strings.create.toUpperCase()}',
                            style: theme.textTheme.displayLarge?.copyWith(
                              foreground: TextThemes.foreground,
                            ),
                          ),
                          TextSpan(
                            text: Strings.orderNow.toUpperCase(),
                            style: theme.textTheme.displayLarge,
                          ),
                          TextSpan(
                            text: Strings.sky.toUpperCase(),
                            style: theme.textTheme.displayLarge?.copyWith(
                              foreground: TextThemes.foreground,
                            ),
                          ),
                          TextSpan(
                            text: Strings.waitingForYou.toUpperCase(),
                            style: theme.textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
