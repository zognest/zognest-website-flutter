import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
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
    final size = MediaQuery.sizeOf(context);
    final screenWidth = html.window.screen!.width!;
    return Column(
      children: [
        const SizedBox(height: Constants.appBarHeight * 1.5),
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
              Expanded(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      Assets.phoneHand,
                      width: (size.width > screenWidth
                              ? screenWidth
                              : size.width) *
                          0.35,
                    ),
                    Positioned(
                      right: (size.width > screenWidth
                              ? screenWidth
                              : size.width) *
                          0.1505,
                      top: size.width > screenWidth ? 10 : size.width * 0.005,
                      child: SizedBox(
                        width: (size.width > screenWidth
                                ? screenWidth
                                : size.width) *
                            0.158,
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
  late final Timer timer;
  int currentIndex = 0;
  bool dragging = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: Constants.beyondSpaceAppDuration),
      (_) => nextIndex(),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void nextIndex() {
    final nextIndex = currentIndex + 1;
    setState(() {
      currentIndex = nextIndex % Data.beyondSpaceImages.length;
    });
  }

  void previousIndex() {
    final previousIndex = currentIndex - 1;
    setState(() {
      currentIndex = previousIndex % Data.beyondSpaceImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Palette.black,
            borderRadius: BorderRadius.circular(
              Responsive.isDesktop(context) ? Spacing.l40 : Spacing.m20,
            ),
          ),
          child: GestureDetector(
            onTap: nextIndex,
            onHorizontalDragUpdate: (drag) {
              if (dragging) {
                dragging = false;
                if (drag.delta.dx < 0) nextIndex();
                if (drag.delta.dx > 0) previousIndex();
              }
            },
            onHorizontalDragStart: (_) => dragging = true,
            onHorizontalDragCancel: () => dragging = true,
            onHorizontalDragEnd: (_) => dragging = true,
            child: AnimatedSwitcher(
              duration: const Duration(
                  milliseconds: Constants.appMockAnimationDuration),
              child: Image.asset(
                Data.beyondSpaceImages[currentIndex],
                key: ValueKey(currentIndex),
              ),
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
                  duration: const Duration(
                      milliseconds: Constants.appMockAnimationDuration),
                );
              },
            ),
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
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context)
            ? Constants.webHorizontalPadding
            : Constants.mobileHorizontalPadding,
        vertical: Constants.appBarHeight * 1.5,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Assets.phoneHand,
                width: size.width * 0.85,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: size.width * 0.1,
                top: 5,
                child: SizedBox(
                  width: size.width * 0.384,
                  child: const BeyondSpaceCarousel(),
                ),
              ),
            ],
          ),
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
