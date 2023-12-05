import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.webHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.beyond.toUpperCase(),
                            style: theme.textTheme.displayMedium,
                          ),
                          Text(
                            Strings.space.toUpperCase(),
                            style: theme.textTheme.displayMedium?.copyWith(
                              foreground: TextThemes.foreground,
                            ),
                          ),
                          Text(
                            Strings.beyondSpaceBody,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.l48),
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
              const Expanded(
                child: BeyondSpaceCarousel(),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class BeyondSpaceCarousel extends StatefulWidget {
  const BeyondSpaceCarousel({super.key});

  @override
  State<BeyondSpaceCarousel> createState() => _BeyondSpaceCarouselState();
}

class _BeyondSpaceCarouselState extends State<BeyondSpaceCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: Data.beyondSpaceImages.map((image) {
            return Image.asset(image);
          }).toList(),
          options: CarouselOptions(
            // aspectRatio: 1,
            viewportFraction: 0.25,
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            autoPlayInterval:
                const Duration(seconds: Constants.beyondSpaceAppDuration),
            autoPlay: true,
            onPageChanged: (index, _) => setState(() => currentIndex = index),
          ),
        ),
        const SizedBox(height: Spacing.l48),
        SizedBox(
          width: Spacing.xl72,
          height: Spacing.s4,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: Spacing.xl72,
                height: Spacing.s4,
                decoration: ShapeDecoration(
                  color: Palette.white.withOpacity(0.2),
                  shape: const StadiumBorder(),
                ),
              ),
              AnimatedPadding(
                duration: const Duration(milliseconds: 800),
                curve: Curves.ease,
                padding: EdgeInsets.only(
                  left: (currentIndex + 1) *
                      (Spacing.xl72 / Data.beyondSpaceImages.length),
                ),
                child: Container(
                  width: Spacing.xl72 / Data.beyondSpaceImages.length,
                  height: Spacing.s4,
                  decoration: const ShapeDecoration(
                    color: Palette.white,
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BeyondSpaceMobile extends StatelessWidget {
  const BeyondSpaceMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.mobileHorizontalPadding,
      ),
      child: Column(
        children: [
          const BeyondSpaceCarousel(),
          const SizedBox(height: Spacing.s12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.beyond.toUpperCase(),
                  style: theme.textTheme.displayMedium,
                ),
                Text(
                  Strings.space.toUpperCase(),
                  style: theme.textTheme.displayMedium?.copyWith(
                    foreground: TextThemes.foreground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.m20),
          Text(
            Strings.beyondSpaceBody,
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
    );
  }
}
