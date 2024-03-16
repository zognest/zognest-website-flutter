import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../../config/responsive.dart';

class ZognestOffers extends HookWidget {
  ZognestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final currentIndex = useState(1);
    final hoveredIndex = useState(-1);
    final showAnimatedHeadline = useState(false);
    final animationController =
        useAnimationController(duration: const Duration(seconds: 2));
    final theme = Theme.of(context);

    return Column(
      children: [
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction == 1) showAnimatedHeadline.value = true;
            if (info.visibleFraction <= 0.5) showAnimatedHeadline.value = false;
          },
          key: ValueKey(runtimeType.toString()),
          child: ScrollHeadline(
            headline: TextSpan(
              text: "${Strings.what}\n".toUpperCase(),
              style: theme.textTheme.displaySmall,
              children: [
                TextSpan(
                  text: Strings.we.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    foreground: TextThemes.foreground,
                  ),
                ),
                TextSpan(
                    text: Strings.offer.toUpperCase(),
                    style: theme.textTheme.displaySmall?.copyWith()),
              ],
            ),
            showHeadline: showAnimatedHeadline.value,
            onTapScroll: () {
              if (scrollController.offset ==
                  scrollController.position.maxScrollExtent) {
                currentIndex.value = 0;
              }
              scrollController.animateTo(
                Constants.zognestOffersItemWidth * currentIndex.value,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
              currentIndex.value++;
            },
          ),
        ),
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 0.8) animationController.forward();
          },
          key: ValueKey('${runtimeType.toString()} List'),
          child: Consumer(
            builder: (context, ref, child) {
              final offers = ref.watch(appControllerProvider).offers;
              return offers.when(
                data: (offers) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          animationController.repeat();
                        },
                        child: const Text('Repeat Animation'),
                      ),
                      SizedBox(
                        height: Constants.zognestOffersListHeight,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.horizontalPadding),
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return AnimatedListItem(
                              aniController: animationController,
                              index: index,
                              length: offers.length,
                              animationType: AnimationType.slide,
                              startX: 1,
                              child: InkWell(
                                onTap: () {},
                                onHover: (over) {
                                  hoveredIndex.value = over ? index : -1;
                                },
                                child: OfferItem(
                                  offer: offers[index],
                                  colored: hoveredIndex.value == index,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                              width: Responsive.isDesktop(context)
                                  ? Constants.listCardSeparatorWidth
                                  : Constants.listCardSeparatorWidthMobile),
                          itemCount: offers.length,
                        ),
                      ),
                    ],
                  );
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ZognestOffersMobile extends HookWidget {
  const ZognestOffersMobile({super.key});

  @override
  Widget build(context) {
    final showAnimatedHeadline = useState(false);
    final theme = Theme.of(context);
    return Column(
      children: [
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction == 1) showAnimatedHeadline.value = true;
            if (info.visibleFraction <= 0.5) showAnimatedHeadline.value = false;
          },
          key: ValueKey(runtimeType.toString()),
          child: ScrollHeadline(
            headline: TextSpan(
              text: '${Strings.what}\n'.toUpperCase(),
              style: theme.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: Strings.we.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    foreground: TextThemes.foreground,
                  ),
                ),
                TextSpan(text: Strings.offer.toUpperCase()),
              ],
            ),
            showHeadline: showAnimatedHeadline.value,
            onTapScroll: null,
          ),
        ),
        Consumer(builder: (__, ref, _) {
          final offers = ref.watch(appControllerProvider).offers;
          return offers.when(
            data: (offers) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                addAutomaticKeepAlives: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mobileHorizontalPadding,
                ),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return OfferItem(offer: offers[index]);
                },
                separatorBuilder: (_, __) =>
                const SizedBox(height: Spacing.s12),
                itemCount: offers.length,
              );
            },
            error: (_, __) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
          );
        }),
        const Divider(),
      ],
    );
  }
}

class OfferItem extends StatelessWidget {
  const OfferItem({
    super.key,
    required this.offer,
    this.colored = false,
  });

  final Offer offer;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        side: BorderSide(width: 0.5, color: Color(0xff121212)),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Container(
        width: !Responsive.isMobile(context)
            ? Constants.zognestOffersItemWidth
            : double.infinity,
        height: Constants.zognestOffersListHeight,
        color: colored ? theme.primaryColor : Palette.cardBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.l32,
          vertical: Spacing.l48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.highlight.toUpperCase(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro Rounded',
                fontSize: Responsive.isMobile(context) ? 28 : 38,
                color: colored ? Colors.black : theme.primaryColor,
                fontVariations: TextThemes.fontVariation(3),
              ),
            ),
            Text(
              offer.title.toUpperCase(),
              style: theme.textTheme.headlineMedium?.copyWith(
                color: colored ? Colors.black : null,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context) ? 28 : 38,
                fontFamily: 'SF Pro Rounded',
              ),
            ),
            const SizedBox(height: Spacing.s12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  offer.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colored ? Colors.black : null,
                    fontFamily: 'SF Pro Rounded',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
