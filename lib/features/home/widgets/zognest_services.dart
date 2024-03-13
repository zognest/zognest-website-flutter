import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../riverpod/controller.dart';
import '../../../shared/widgets/network_fading_image.dart';
import '../../../shared/widgets/technology_container.dart';
import '../../our_services/pages/our_services_page.dart';

class ZognestServices extends StatefulWidget {
  const ZognestServices({super.key});

  @override
  State<ZognestServices> createState() => _ZognestServicesState();
}

class _ZognestServicesState extends State<ZognestServices> {
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
            text: 'services \n'.toUpperCase(),
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
          onTapScroll: Responsive.isDesktop(context)
              ? () {
                  if (_controller.offset ==
                      _controller.position.maxScrollExtent) {
                    currentIndex = 0;
                  }
                  _controller.animateTo(
                    Constants.servicesCardWidth * currentIndex,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease,
                  );
                  currentIndex++;
                }
              : null,
        ),
        Consumer(builder: (context, ref, child) {
          final services = ref.watch(appControllerProvider).services;
          return services.when(
            data: (services) {
              return !Responsive.isMobile(context)
                  ? SizedBox(
                      height: Constants.servicesCardHeight,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.horizontalPadding),
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return Container(
                            constraints: BoxConstraints.tight(
                              const Size(
                                Constants.servicesCardWidth,
                                Constants.servicesCardHeight,
                              ),
                            ),
                            child: FlippingWidget(
                              front: FrontService(service: services[index]),
                              back: BackService(service: services[index]),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                            width: Responsive.isDesktop(context)
                                ? Constants.listCardSeparatorWidth
                                : Constants.listCardSeparatorWidthMobile),
                        itemCount: services.length,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.mobileHorizontalPadding,
                      ),
                      child: Column(
                        children: services
                            .map(
                              (service) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: Spacing.s12),
                                child: SizedBox(
                                  height: Constants.servicesCardHeight,
                                  width: double.infinity,
                                  child: FlippingWidget(
                                    front: FrontService(service: service),
                                    back: BackService(service: service),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
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

class FrontService extends StatelessWidget {
  const FrontService({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          GreyscaleFilter(
            opacity: 0.3,
            isHovered: false,
            child: NetworkFadingImage(
              path: service.backgroundImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.l24,
              vertical: Spacing.l32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        service.highlight.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: Responsive.isMobile(context) ? 28 : 38,
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        service.title.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.isMobile(context) ? 28 : 38,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Spacing.m20),
                          child: Text(
                            service.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                fontSize:
                                    Responsive.isDesktop(context) ? 20 : 16,
                                height: 1.3),
                          ),
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
      ),
    );
  }
}

class BackService extends StatelessWidget {
  const BackService({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: NetworkFadingImage(
              path: service.backgroundImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.l24,
              vertical: Spacing.l32,
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
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: Responsive.isMobile(context) ? 28 : 38,
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        service.title.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.isMobile(context) ? 28 : 38,
                        ),
                      ),
                      const SizedBox(height: Spacing.m20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(vertical: Spacing.s12),
                          child: Wrap(
                            runSpacing: Spacing.s8,
                            spacing: Spacing.s8,
                            children: service.technologies.map(
                              (tech) {
                                return TechnologyContainer(
                                  image: tech.image,
                                  title: tech.name,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      )
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
                  onTap: () {
                    context.go(OurServicesPage.route);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
