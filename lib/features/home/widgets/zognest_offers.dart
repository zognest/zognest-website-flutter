// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../../config/responsive.dart';

class ZognestOffers extends StatefulWidget {
  const ZognestOffers({super.key});

  @override
  State<ZognestOffers> createState() => _ZognestOffersState();
}

class _ZognestOffersState extends State<ZognestOffers> {
  late final ScrollController _controller;
  int currentIndex = 1;

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
        SizedBox(
          height: Constants.zognestOffersListHeight,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.webHorizontalPadding),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.offers.length;
                final offer = Data.offers[i];
                return OfferItem(offer: offer);
              },
              separatorBuilder: (context, index) =>
              const SizedBox(width: Spacing.l24),
              itemCount: 10,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class ZognestOffersMobile extends StatelessWidget {
  const ZognestOffersMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.mobileHorizontalPadding,
          ),
          child: Column(
            children: Data.offers
                .mapIndexed(
                  (index, offer) => Padding(
                padding: const EdgeInsets.only(bottom: Spacing.s12),
                child: OfferItem(offer: offer, colored: index == 0),
              ),
            )
                .toList(),
          ),
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
          horizontal: Spacing.l32, vertical: Spacing.l48),
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