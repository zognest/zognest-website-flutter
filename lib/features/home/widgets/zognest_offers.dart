import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';

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
    final size = MediaQuery.sizeOf(context);
    final itemWidth = size.width * 0.2;
    return Column(
      children: [
        const Divider(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.webHorizontalPadding,
                vertical: Spacing.l40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    textScaleFactor: TextThemes.textScale(context),
                    TextSpan(
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
                  ),
                  InkWell(
                    onTap: () {
                      if (_controller.offset ==
                          _controller.position.maxScrollExtent) {
                        currentIndex = 0;
                      }
                      _controller.animateTo(
                        itemWidth * currentIndex,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.ease,
                      );
                      currentIndex++;
                    },
                    overlayColor:
                        MaterialStateProperty.all(Palette.transparent),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              textScaleFactor: TextThemes.textScale(context),
                              Strings.scroll.toUpperCase(),
                              style: theme.textTheme.displaySmall
                                  ?.copyWith(fontSize: 54),
                            ),
                            Text(
                              textScaleFactor: TextThemes.textScale(context),
                              Strings.toExploreMore.toUpperCase(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.primaryColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: Spacing.l24),
                        Image.asset(Assets.arrowRight),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
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
                    return ListItem(
                      offer: offer,
                      width: itemWidth,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: Spacing.l24),
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.offer,
    required this.width,
  });

  final Offer offer;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FrostedContainer(
      width: width,
      padding: const EdgeInsets.all(Spacing.l32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.highlight.toUpperCase(),
            style: theme.textTheme.headlineSmall
                ?.copyWith(color: theme.primaryColor),
          ),
          Text(
            offer.title.toUpperCase(),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: Spacing.s12),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                offer.description,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
