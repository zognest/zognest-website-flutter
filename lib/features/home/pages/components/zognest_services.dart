import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/features/home/widgets/scroll_headline.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

class ZognestServices extends StatefulWidget {
  const ZognestServices({super.key});

  @override
  State<ZognestServices> createState() => _ZognestServicesState();
}

class _ZognestServicesState extends State<ZognestServices> {
  late final ScrollController _controller;
  late final FlipCardController _flipController;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _flipController = FlipCardController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _flipController.state?.dispose();
    _flipController.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    const itemWidth = Constants.servicesCardWidth;
    return Column(
      children: [
        const Divider(),
        ScrollHeadline(
          headline: TextSpan(
            text: Strings.services.toUpperCase(),
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
              itemWidth * currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
            currentIndex++;
          },
        ),
        SizedBox(
          height: Constants.servicesCardHeight,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.pageHorizontalPadding),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.services.length;
                final service = Data.services[i];
                return Container(
                  constraints: BoxConstraints.tight(
                      const Size(itemWidth, Constants.servicesCardHeight)),
                  child: FlippingWidget(
                    front: FrontService(service: service),
                    back: BackService(service: service),
                  ),
                );
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

class FrontService extends StatelessWidget {
  const FrontService({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Image.asset(
          Assets.serviceBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.l24,
            vertical: Spacing.l32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      service.highlight.toUpperCase(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.primaryColor,
                        fontVariations: TextThemes.fontVariation(1),
                      ),
                    ),
                    Text(
                      service.title.toUpperCase(),
                      style: theme.textTheme.headlineMedium,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: Spacing.m20),
                      child: Text(
                        service.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style:
                            theme.textTheme.bodyMedium?.copyWith(height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                title: Strings.more.toUpperCase(),
                filled: false,
                width: Constants.servicesCardWidth * 0.4,
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.s12,
                  vertical: Spacing.m20,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BackService extends StatelessWidget {
  const BackService({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Image.asset(
          Assets.serviceBackground,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Spacing.l24,
            right: Spacing.l24,
            top: Spacing.l48,
            bottom: Spacing.l32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.highlight.toUpperCase(),
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(color: theme.primaryColor),
                    ),
                    Text(
                      service.title.toUpperCase(),
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: Spacing.m20),
                    Expanded(
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.s12),
                        child: Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          alignment: WrapAlignment.start,
                          runSpacing: Spacing.s12,
                          spacing: Spacing.s12,
                          children: service.technologies.map((tech) {
                            return TechnologyContainer(
                              image: tech.image,
                              title: tech.name,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                title: Strings.add.toUpperCase(),
                width: Constants.servicesCardWidth * 0.4,
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.s12,
                  vertical: Spacing.m20,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
