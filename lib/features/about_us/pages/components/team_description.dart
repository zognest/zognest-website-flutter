import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';

class TeamDescription extends StatelessWidget {
  const TeamDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const Divider(),
        Stack(
          alignment: Alignment.center,
          children: [
            const GradientContainer(
              color: Colors.deepPurple,
              height: Constants.zognestDescriptionSectionHeight,
              alignment: Alignment(0.3, 0),
              width: double.infinity,
              radius: 1,
            ),
            FrostedContainer(
              height: Constants.zognestDescriptionSectionHeight,
              blurStrength: 8,
              backgroundColor: Palette.cardBackgroundColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.pageHorizontalPadding),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.zognestTeam,
                      height: double.infinity,
                      width: size.width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: Spacing.l40),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.l40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AutoSizeText.rich(
                                stepGranularity: 4,
                                maxLines: 5,
                                TextSpan(
                                  text:
                                      Strings.helpingYourBusiness.toUpperCase(),
                                  style: theme.textTheme.displaySmall,
                                  children: [
                                    TextSpan(
                                      text: Strings.to.toUpperCase(),
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        fontVariations:
                                            TextThemes.fontVariation(3),
                                      ),
                                    ),
                                    TextSpan(
                                        text: Strings.exploreThe.toUpperCase()),
                                    TextSpan(
                                      text: Strings.sky.toUpperCase(),
                                      style: theme.textTheme.displaySmall
                                          ?.copyWith(
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AutoSizeText(
                              stepGranularity: 4,
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
          ],
        ),
        const Divider(),
      ],
    );
  }
}
