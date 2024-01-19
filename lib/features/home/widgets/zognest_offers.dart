import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../../config/responsive.dart';

class ZognestOffers extends ConsumerStatefulWidget {
  const ZognestOffers({super.key});

  @override
  ConsumerState<ZognestOffers> createState() => _ZognestOffersState();
}

class _ZognestOffersState extends ConsumerState<ZognestOffers> {
  late final ScrollController _controller;
  int currentIndex = 1;
  int hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offers = ref.watch(appControllerProvider).offers;
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        ScrollHeadline(
          headline: TextSpan(
            text: Strings.what.toUpperCase(),
            style: theme.textTheme.displaySmall,
            children: [
              TextSpan(
                text: '${Strings.we}\n'.toUpperCase(),
                style: theme.textTheme.displaySmall?.copyWith(
                  foreground: TextThemes.foreground,
                ),
              ),
              TextSpan(text: Strings.offer.toUpperCase()),
            ],
          ),
          onTapScroll: () {
            if (_controller.offset == _controller.position.maxScrollExtent) {
              currentIndex = 0;
            }
            _controller.animateTo(
              Constants.zognestOffersItemWidth * currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
            currentIndex++;
          },
        ),
        Consumer(builder: (_, ref, __) {
          return offers.when(
            data: (offers) {
              return SizedBox(
                height: Constants.zognestOffersListHeight,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      onHover: (over) {
                        if (over) {
                          hoveredIndex = index;
                          setState(() {});
                          return;
                        }
                        hoveredIndex = -1;
                        setState(() {});
                      },
                      child: OfferItem(
                        offer: offers[index],
                        colored: hoveredIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: Spacing.l24),
                  itemCount: offers.length,
                ),
              );
            },
            error: (_, __) => const Text('error'),
            loading: () => CircularProgressIndicator(color: theme.primaryColor),
          );
        }),
        const Divider(),
      ],
    );
  }
}

class ZognestOffersMobile extends StatelessWidget {
  const ZognestOffersMobile({super.key});

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        ScrollHeadline(
          headline: TextSpan(
            text: Strings.what.toUpperCase(),
            style: theme.textTheme.displaySmall,
            children: [
              TextSpan(
                text: '${Strings.we}\n'.toUpperCase(),
                style: theme.textTheme.displaySmall?.copyWith(
                  foreground: TextThemes.foreground,
                ),
              ),
              TextSpan(text: Strings.offer.toUpperCase()),
            ],
          ),
          onTapScroll: null,
        ),
        Consumer(
          builder: (__, ref, _) {
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
          },
        ),
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
    return Container(
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
              color: colored ? Colors.black : theme.primaryColor,
              fontVariations: TextThemes.fontVariation(3),
            ),
          ),
          Text(
            offer.title.toUpperCase(),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colored ? Colors.black : null,
            ),
          ),
          const SizedBox(height: Spacing.s12),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                offer.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colored ? Colors.black : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
