import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';

class ZognestDescription extends StatelessWidget {
  const ZognestDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        FrostedContainer(
          height: Constants.zognestDescriptionSectionHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.webHorizontalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    Assets.office,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: Spacing.l40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.l40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                              text: Strings.helpingYourBusiness.toUpperCase(),
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontVariations: TextThemes.fontVariation(7),
                                height: 1.1,
                              ),
                              children: [
                                TextSpan(
                                  text: Strings.sky.toUpperCase(),
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontVariations: TextThemes.fontVariation(7),
                                    height: 1.1,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ]),
                          textScaleFactor: TextThemes.textScale(context),
                        ),
                        AutoSizeText(
                          Strings.zognestDescription,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
