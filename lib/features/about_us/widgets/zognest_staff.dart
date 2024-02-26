// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

import '../../../shared/widgets/network_fading_image.dart';

class ZognestStaff extends StatefulWidget {
  const ZognestStaff({super.key});

  @override
  State<ZognestStaff> createState() => _ZognestServicesStaff();
}

class _ZognestServicesStaff extends State<ZognestStaff> {
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
            text: '',
            style: theme.textTheme.displaySmall,
            children: [
              TextSpan(
                text: '${Strings.our.toUpperCase()}\n',
                style: theme.textTheme.displaySmall
                    ?.copyWith(foreground: TextThemes.foreground),
              ),
              TextSpan(text: Strings.birds.toUpperCase()),
            ],
          ),
          onTapScroll: () {
            if (_controller.offset == _controller.position.maxScrollExtent) {
              currentIndex = 0;
            }
            _controller.animateTo(
              Constants.servicesCardWidth * currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
            currentIndex++;
          },
        ),
        Consumer(builder: (__, ref, _) {
          final staff = ref.watch(appControllerProvider).staff;
          return staff.when(
              data: (staff) {
                return SizedBox(
                  height: Constants.listHeight,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: Responsive.isDesktop(context)
                            ? Constants.listCardWidth
                            : 300,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: FlippingWidget(
                            front: FrontCard(staff: staff[index]),
                            back: BackCard(staff: staff[index]),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width:Responsive.isDesktop(context)
                          ? 16
                          : 6
                    ),
                    itemCount: staff.length,
                  ),
                );
              },
              error: (_, __) => const Text('error'),
              loading: () =>
                  CircularProgressIndicator(color: theme.primaryColor));
        }),
        const Divider(),
      ],
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Palette.cardBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Container(
                color: staff.color,
                width: double.infinity,
                child: NetworkFadingImage(
                  path: staff.avatar,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.l24,
                vertical: Spacing.l24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff.name.toUpperCase(),
                          style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 32, fontFamily: 'SF Pro Rounded'),
                        ),
                        Text(
                          staff.position.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro Rounded'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Spacing.m14,
                            ),
                            child: Text(
                              staff.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                fontSize:
                                    Responsive.isDesktop(context) ? 20 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    title: Strings.more.toUpperCase(),
                    filled: false,
                    width: Constants.listCardWidth * 0.3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.listButtonHorizontalPadding,
                      vertical: Constants.listButtonVerticalPadding,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Palette.cardBackgroundColor,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ColoredBox(
              color: staff.color,
              child: NetworkFadingImage(
                path: staff.avatar,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.l24,
              vertical: Spacing.l24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff.name.toUpperCase(),
                        style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 32, fontFamily: 'SF Pro Rounded'),
                      ),
                      Text(
                        staff.position.toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            staff.description,
                            style: theme.textTheme.bodyLarge?.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                fontSize:
                                    Responsive.isDesktop(context) ? 20 : 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.m20),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(vertical: Spacing.s12),
                          child: Wrap(
                            runSpacing: Spacing.s8,
                            spacing: Spacing.s8,
                            children: staff.technologies.map((tech) {
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
                  title: Strings.linkedIn.toUpperCase(),
                  width: Constants.listCardWidth * 0.3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.listButtonHorizontalPadding,
                    vertical: Constants.listButtonVerticalPadding,
                  ),
                  onTap: () => js.context.callMethod('open', [staff.url]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
