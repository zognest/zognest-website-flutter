import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, this.hasGradient = false, required this.image});

  final bool hasGradient;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Responsive.isDesktop(context)
        ? Column(
            children: [
              const Divider(),
              Stack(
                alignment: Alignment.center,
                children: [
                  if (hasGradient)
                    const GradientContainer(
                      color: Colors.deepPurple,
                      height: Constants.imageTextHeight,
                      alignment: Alignment(0.5, 0),
                      radius: 0.8,
                    ),
                  FrostedContainer(
                    height: Constants.imageTextHeight,
                    blurStrength: 4,
                    backgroundColor:
                        Palette.cardBackgroundColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.webHorizontalPadding,
                      ),
                      child: Row(
                        children: [
                          //image
                          Expanded(
                            child: Image.asset(
                              image,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          //width between image and text
                          const SizedBox(width: Spacing.l40),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Spacing.l32),
                              child: Opacity(
                                opacity:.6,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText.rich(
                                        stepGranularity: 1,
                                        maxLines: 5,
                                        TextSpan(
                                          text: Strings.helpingYourBusiness
                                              .toUpperCase(),
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
                                                text: Strings.exploreThe
                                                    .toUpperCase()),
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
                                    Text(
                                      Strings.zognestDescription,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
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
          )
        : ImageTextMobile(image: image);
  }
}

class ImageTextMobile extends StatelessWidget {
  const ImageTextMobile({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.m20,
            horizontal: Constants.mobileHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text.rich(
                  TextSpan(
                    text: '${Strings.helpingYourBusiness.toUpperCase()}\n',
                    style: theme.textTheme.displaySmall,
                    children: [
                      TextSpan(
                        text: Strings.to.toUpperCase(),
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontVariations: TextThemes.fontVariation(3),
                        ),
                      ),
                      TextSpan(text: Strings.exploreThe.toUpperCase()),
                      TextSpan(
                        text: Strings.sky.toUpperCase(),
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                Strings.zognestDescription,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
