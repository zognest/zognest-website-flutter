import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  const BeyondSpace({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const SizedBox(height: Constants.appBarSpacing),
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
                    const SizedBox(height: Spacing.m20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          title: Strings.bookOurServices.toUpperCase(),
                          onTap: () {},
                        ),
                        const CircleButton(asset: Assets.downArrow),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      Assets.phoneHand,
                      width: size.width * 0.335,
                    ),
                    Positioned(
                      right: size.width * 0.144,
                      top: size.width * 0.0055,
                      child: SizedBox(
                        width: size.width * 0.151,
                        child: const BeyondSpaceCarousel(),
                      ),
                    ),
                  ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Spacing.l24),
          child: CarouselSlider(
            items: Data.beyondSpaceImages
                .map((asset) => Image.asset(asset))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 0.465,
              autoPlay: true,
              onPageChanged: (index, _) {
                currentIndex = index;
                setState(() {});
              },
            ),
          ),
        ),
        const SizedBox(height: Spacing.l48),
        Container(
          width: Spacing.xl72,
          height: Spacing.s4,
          decoration: ShapeDecoration(
            color: Palette.white.withOpacity(0.2),
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              Data.beyondSpaceImages.length,
              (index) {
                return AnimatedContainer(
                  width: Spacing.xl72 / Data.beyondSpaceImages.length,
                  height: Spacing.s4,
                  curve: Curves.ease,
                  decoration: ShapeDecoration(
                    color: Palette.white
                        .withOpacity(currentIndex == index ? 1 : 0),
                    shape: const StadiumBorder(),
                  ),
                  duration: const Duration(milliseconds: 400),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
