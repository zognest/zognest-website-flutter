import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_space/widgets/event_card.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/riverpod/controller.dart';

class ZognestEvents extends ConsumerStatefulWidget {
  const ZognestEvents({super.key});

  @override
  ConsumerState<ZognestEvents> createState() => _ZognestEventsState();
}

class _ZognestEventsState extends ConsumerState<ZognestEvents> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(appControllerProvider).events;
    final theme = Theme.of(context);
    return events.when(
      data: (events) {
        final eventsYears =
            events.map((event) => event.date.year).toSet().toList();
        return Column(
          children: [
            if (Responsive.isDesktop(context)) const Divider(),
            DefaultTabController(
              length: eventsYears.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                    ),
                    indicator: ShapeDecoration(
                      color: theme.primaryColor,
                      shape: const StadiumBorder(),
                    ),
                    onTap: (index) => setState(() => this.index = index),
                    dividerColor: Palette.transparent,
                    indicatorColor: Palette.transparent,
                    unselectedLabelStyle: theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    labelColor: Palette.white,
                    labelStyle: theme.textTheme.labelLarge,
                    indicatorSize: TabBarIndicatorSize.tab,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor:
                        MaterialStateProperty.all(Palette.transparent),
                    tabs: eventsYears.map((year) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context)
                              ? Spacing.l40
                              : Spacing.m20,
                        ),
                        decoration: ShapeDecoration(
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: eventsYears[index] == year
                                  ? Palette.transparent
                                  : Palette.white,
                            ),
                          ),
                        ),
                        child: Tab(
                          text: '$year',
                          height: Responsive.isDesktop(context)
                              ? Constants.eventsDesktopTabHeight
                              : Constants.eventsMobileTabHeight,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: Spacing.l40),
                  SizedBox(
                    height: Constants.listHeight,
                    child: TabBarView(
                      children: eventsYears.map((year) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Constants.horizontalPadding,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: Constants.listCardWidth,
                              child: EventCard(
                                event: events
                                    .where((event) => event.date.year == year)
                                    .toList()[index],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: Constants.listCardSeparatorWidth *
                                (Responsive.isDesktop(context) ? 1 : 0.5),
                          ),
                          itemCount: events
                              .where((event) => event.date.year == year)
                              .length,
                        );
                      }).toList(),
                    ),
                  ),
                ],
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
