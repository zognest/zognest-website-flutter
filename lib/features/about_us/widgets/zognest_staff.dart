import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

class ZognestStaff extends ConsumerStatefulWidget {
  const ZognestStaff({super.key});

  @override
  ConsumerState<ZognestStaff> createState() => _ZognestServicesStaff();
}

class _ZognestServicesStaff extends ConsumerState<ZognestStaff> {
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
    final staff = ref.watch(appControllerProvider).staff;
    return staff.when(
        data: (staff) {
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
                },
              ),
              SizedBox(
                height: Constants.listHeight,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context)
                        ? Constants.webHorizontalPadding
                        : Constants.mobileHorizontalPadding,
                  ),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (context, index) {
                   /* final i = index % Data.staff.length;
                    final staff = Data.staff[i];*/
                    return SizedBox(
                      width: Constants.listCardWidth,
                      child: FlippingWidget(
                        front: FrontCard(staff:staff[index]),
                        back: BackCard(staff:staff[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: Constants.listCardSeparatorWidth *
                        (Responsive.isDesktop(context) ? 1 : 0.5),
                  ),
                  itemCount: staff.length,
                ),
              ),
              const Divider(),
            ],
          );
        },
        error: (_, __) => const Text('error'),
        loading: () => CircularProgressIndicator(color: theme.primaryColor));
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Image.network(
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
                            vertical: Spacing.m20,
                          ),
                          child: Text(
                            staff.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: theme.textTheme.bodyLarge,
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
        Image.network(
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
                          style: theme.textTheme.bodyLarge,
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
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
