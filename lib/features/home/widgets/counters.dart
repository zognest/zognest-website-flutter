import 'package:animated_list_item/animated_list_item.dart';
import 'package:collection/collection.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/animation_image.dart';

class Counters extends HookWidget {
  const Counters({super.key});

  @override
  Widget build(BuildContext context) {
    final countersAnimationController = useAnimationController(
      duration: const Duration(
        milliseconds: Constants.countersAnimationDuration,
      ),
    );
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return RadialGradient(
                          colors: [
                            Palette.white.withOpacity(0.5),
                            theme.scaffoldBackgroundColor,
                          ],
                          radius: 3.8,
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      child: AnimatedImage(
                        index: 0,
                        length: 2,
                        child: Text(
                          Strings.someCountThatMatters.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: theme.textTheme.displayLarge?.copyWith(
                            foreground: TextThemes.foreground,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                    ),
                    // delet fitted box from here
                    child: AnimatedImage(
                      index: 1,
                      length: 2,
                      child: Text(
                        Strings.someCountThatMatters.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: Responsive.isDesktop(context) ? 42 : 18,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.horizontalPadding),
                child: VisibilityDetector(
                  key: ValueKey('${runtimeType.toString()} List'),
                  onVisibilityChanged: (info) {
                    if (countersAnimationController.isCompleted) return;
                    if (info.visibleFraction == 1) {
                      countersAnimationController.forward();
                    }
                  },
                  child: Consumer(
                      builder: (context, ref, index) {
                    final counter = ref.watch(appControllerProvider).counters;
                    return counter.when(
                        data: (counter) {
                          return Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            runSpacing: 16,
                            spacing: 16,
                            children: counter.mapIndexed((index, item) {
                              return AnimatedImage(
                                  length: counter.length,
                                  index: item.index,
                                  child: CounterItem(
                                    title: item.title,
                                    count: item.count,
                                    controller: countersAnimationController,
                                  ));
                            }).toList(),
                          );
                        },
                        error: (_, __) => const SizedBox.shrink(),
                        loading: () => const SizedBox.shrink());
                  }),
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

class CounterItem extends StatelessWidget {
  const CounterItem({
    super.key,
    required this.count,
    required this.title,
    this.hasPlus = true,
    required this.controller,
  });

  final int count;
  final String title;
  final bool hasPlus;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Constants.countItemHeight,
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Countup(
                  animationController: controller,
                  begin: 0,
                  end: count.toDouble(),
                  separator: ',',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.primaryColor,
                    fontSize: Responsive.isMobile(context) ? 40 : 72,
                    height: 1,
                  ),
                ),
                if (hasPlus)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '+',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: Responsive.isMobile(context) ? 20 : 60,
                        color: theme.primaryColor,
                        height: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.s12),
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
/*  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding),
                    child: VisibilityDetector(
                      key: ValueKey(runtimeType.toString()),
                      onVisibilityChanged: (info) {
                        if (countersAnimationController.isCompleted) return;
                        if (info.visibleFraction == 1) {
                          countersAnimationController.forward();
                        }
                      },
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        runSpacing: 16,
                        spacing: 16,
                        children: [
                          AnimatedImage(
                            index: 0,
                            length: 5,
                            child: CounterItem(
                              count: 09,
                              title: Strings.appDevelopment,
                              controller: countersAnimationController,
                            ),
                          ),
                          AnimatedImage(
                            index: 1,
                            length: 5,
                            child: CounterItem(
                              count: 12,
                              title: Strings.webDevelopment,
                              controller: countersAnimationController,
                            ),
                          ),
                          AnimatedImage(
                            index: 2,
                            length: 5,
                            child: CounterItem(
                              count: 17,
                              title: Strings.uiUxForCompanies,
                              controller: countersAnimationController,
                            ),
                          ),
                          AnimatedImage(
                            index: 3,
                            length: 5,
                            child: CounterItem(
                              count: 36,
                              title: Strings.happyCustomer,
                              controller: countersAnimationController,
                            ),
                          ),
                          AnimatedImage(
                            index: 4,
                            length: 5,
                            child: CounterItem(
                              count: 36,
                              title: Strings.projectsCompleted,
                              hasPlus: false,
                              controller: countersAnimationController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),*/
