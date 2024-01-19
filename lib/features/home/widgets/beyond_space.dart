import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../shared/widgets/network_fading_image.dart';

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
                        left: Constants.horizontalPadding,
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
                  const Expanded(child: BeyondSpaceCarousel()),
                ],
              ),
              const SizedBox(height: Spacing.l24),
              const Divider(),
            ],
          )
        : const BeyondSpaceMobile();
  }
}
// no update her
class BeyondSpaceCarousel extends ConsumerWidget {
  const BeyondSpaceCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(appControllerProvider).projects;
    return projects.when(
      data: (projects) {
        return CarouselSlider(
          items: projects.map((project) {
            return AspectRatio(
              aspectRatio: 370 / 747,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context) ? 18 : 12,
                  vertical: Responsive.isDesktop(context) ? 16 : 10,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.phoneMockup),
                    fit: BoxFit.fill,
                  ),
                ),
                child: NetworkFadingImage(
                  path:
                  project.splash,
                  fit: BoxFit.fill,
                ),
              ),
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
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
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
            horizontal:Constants.paddingBeyondSpaceMobile,
          ),
          child: Column(
            children: [
              const SizedBox(height: Spacing.l32),
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
