import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

import '../../../riverpod/controller.dart';
import '../../../shared/widgets/network_fading_image.dart';

class ZognestServices extends ConsumerStatefulWidget {
  const ZognestServices({super.key});

  @override
  ConsumerState<ZognestServices> createState() => _ZognestServicesState();
}

class _ZognestServicesState extends ConsumerState<ZognestServices> {
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
    final services = ref.watch(appControllerProvider).services;
    return services.when(
      data: (services) {
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
            !Responsive.isMobile(context)
                ? SizedBox(
              height: Constants.servicesCardHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal:  Constants.paddingHorizontalMobileAndWeb),
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
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: Spacing.l24),
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
                  ),
            const Divider(),
          ],
        );
      },
      error: (_, __) => const Text('error'),
      loading: () => CircularProgressIndicator(color: theme.primaryColor),
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
          NetworkFadingImage(
            path: service.backgroundImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
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
                          fontVariations: TextThemes.fontVariation(1),
                        ),
                      ),
                      Text(
                        service.title.toUpperCase(),
                        style: theme.textTheme.headlineMedium,
                      ),
                      Expanded(
                        child: Padding(
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
          NetworkFadingImage(
            path: service.backgroundImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
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
                            runSpacing: Spacing.s8,
                            spacing: Spacing.s8,
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
      ),
    );
  }
}
