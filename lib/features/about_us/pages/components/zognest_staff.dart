import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/features/home/widgets/scroll_headline.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

class ZognestStaff extends StatefulWidget {
  const ZognestStaff({super.key});

  @override
  State<ZognestStaff> createState() => _ZognestServicesStaff();
}

class _ZognestServicesStaff extends State<ZognestStaff> {
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
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? Constants.webHorizontalPadding
                    : Constants.mobileHorizontalPadding,
              ),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.staff.length;
                final staff = Data.staff[i];
                return Container(
                  constraints: BoxConstraints.tight(
                    Size(
                      Constants.servicesCardWidth -
                          (Responsive.isDesktop(context) ? 0 : 50),
                      Constants.servicesCardHeight,
                    ),
                  ),
                  child: FlippingWidget(
                    front: FrontCard(staff: staff),
                    back: BackCard(staff: staff),
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

class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Constants.servicesCardHeight,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              Assets.zognestTeam,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              color: Palette.cardBackgroundColor,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          staff.name.toUpperCase(),
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          staff.position.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Spacing.m20),
                            child: Text(
                              staff.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.3,
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
    return Stack(
      children: [
        Image.asset(
          Assets.serviceBackground,
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      staff.name.toUpperCase(),
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      staff.position.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          staff.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.3,
                            fontSize: Responsive.isDesktop(context) ? 24 : 16,
                          ),
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
