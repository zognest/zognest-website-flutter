import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

class BeyondSpace extends StatelessWidget {
  const BeyondSpace({super.key, required this.onTabDown});

  final VoidCallback onTabDown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Responsive.isDesktop(context)
        ? Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Constants.webHorizontalPadding,
                        right: Spacing.xl60,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText.rich(
                            TextSpan(
                              text: '${Strings.beyond.toUpperCase()}\n',
                              children: [
                                TextSpan(
                                  text: Strings.space.toUpperCase(),
                                  style:
                                      theme.textTheme.displayMedium?.copyWith(
                                    foreground: TextThemes.foreground,
                                  ),
                                )
                              ],
                            ),
                            maxLines: 2,
                            style: theme.textTheme.displayMedium,
                          ),
                          Text(
                            Strings.beyondSpaceBody,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: Spacing.l32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  title: Strings.bookOurServices.toUpperCase(),
                                  textStyle: theme.textTheme.labelLarge,
                                  height: Spacing.xl72,
                                  onTap: () {},
                                ),
                              ),
                              const Spacer(),
                              CircleButton(
                                onTap: onTabDown,
                                radius: Spacing.l32,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Assets.downArrow),
                                    const SizedBox(height: Spacing.s8),
                                    Container(
                                      height: Constants.circleButtonRadius,
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child: BeyondSpaceCarousel(),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.l24),
              const Divider(),
            ],
          )
        : const BeyondSpaceMobile();
  }
}

class BeyondSpaceCarousel extends StatelessWidget {
  const BeyondSpaceCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Data.beyondSpaceImages.map((image) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Assets.phoneMockup),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Image.asset(
                image,
                height: double.infinity,
              ),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(
        aspectRatio: 1.3,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        padEnds: !Responsive.isDesktop(context),
        autoPlayInterval:
            const Duration(seconds: Constants.beyondSpaceAppDuration),
        autoPlay: true,
      ),
    );
  }
}

class BeyondSpaceMobile extends StatelessWidget {
  const BeyondSpaceMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const BeyondSpaceCarousel(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.mobileHorizontalPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: Spacing.s12),
              AutoSizeText.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: '${Strings.beyond.toUpperCase()}\n',
                  children: [
                    TextSpan(
                      text: Strings.space.toUpperCase(),
                      style: theme.textTheme.displayMedium?.copyWith(
                        foreground: TextThemes.foreground,
                      ),
                    )
                  ],
                ),
                maxLines: 2,
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: Spacing.m20),
              Text(
                Strings.beyondSpaceBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: Spacing.m20),
              PrimaryButton(
                title: Strings.bookOurServices.toUpperCase(),
                textStyle: theme.textTheme.labelLarge,
                height: Spacing.xl72,
                width: double.infinity,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
