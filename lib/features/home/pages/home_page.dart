import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/widgets/beyond_space.dart';
import 'package:zognest_website/features/home/widgets/clients_list.dart';
import 'package:zognest_website/features/home/widgets/zognest_description.dart';
import 'package:zognest_website/features/home/widgets/zognest_video.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';

import '../../../shared/widgets/gradient_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _controller;

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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: _controller.hasClients
                          ? _controller.position.maxScrollExtent * 0.47
                          : size.height,
                      child: Stack(
                        children: [
                          const Stack(
                            children: [
                              GradientContainer(
                                alignment: Alignment(-0.6, -0.7),
                                color: Palette.primaryGradient,
                                secondaryColor: Palette.secondaryGradient,
                              ),
                              GradientContainer(
                                alignment: Alignment(0.6, -0.7),
                                color: Palette.secondaryGradient,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: SvgPicture.asset(
                              Assets.gridLines,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(Assets.mercuries, width: size.width * 0.6),
                  ],
                ),
                const Column(
                  children: [
                    BeyondSpace(),
                    SizedBox(height: Constants.sectionSpacing),
                    ClientsList(),
                    SizedBox(height: Constants.sectionSpacing),
                    ZognestVideo(),
                    SizedBox(height: Constants.sectionSpacing),
                    ZognestDescription(),
                    SizedBox(height: Constants.sectionSpacing),
                    ZognestOffers(),
                    SizedBox(
                      height: 3000,
                      child: Placeholder(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PrimaryAppBar(scrollController: _controller),
        ],
      ),
    );
  }
}

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
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.webHorizontalPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    textScaleFactor: TextThemes.textScale(context),
                    TextSpan(
                      text: Strings.what.toUpperCase(),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontVariations: TextThemes.fontVariation(7),
                      ),
                      children: [
                        TextSpan(
                          text: '${Strings.we}\n'.toUpperCase(),
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontVariations: TextThemes.fontVariation(7),
                            foreground: TextThemes.foreground,
                          ),
                        ),
                        TextSpan(
                          text: Strings.offer.toUpperCase(),
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontVariations: TextThemes.fontVariation(7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _controller.animateTo(
                        400.0 * currentIndex,
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
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 54,
                              ),
                            ),
                            Text(
                              textScaleFactor: TextThemes.textScale(context),
                              Strings.toExploreMore.toUpperCase(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.primaryColor,
                                letterSpacing: 2,
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
              const SizedBox(height: Spacing.l40),
              SizedBox(
                height: 300,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    final i = index % Data.offers.length;
                    final offer = Data.offers[i];
                    return FrostedContainer(
                      width: 400,
                      padding: const EdgeInsets.all(Spacing.l32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${offer.highlight}\n',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: theme.primaryColor),
                          ),
                          Text(
                            offer.title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontVariations: TextThemes.fontVariation(7),
                            ),
                          ),
                          const SizedBox(height: Spacing.s12),
                          Expanded(
                            child: Center(
                              child: Text(
                                offer.description,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: Spacing.l24),
                  itemCount: 10,
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
