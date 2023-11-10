import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_space/widgets/event_card.dart';
import 'package:zognest_website/resources/spacing.dart';

class ZognestEvents extends StatefulWidget {
  const ZognestEvents({super.key, required this.events});

  final List<Event> events;

  @override
  State<ZognestEvents> createState() => _ZognestEventsState();
}

class _ZognestEventsState extends State<ZognestEvents> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsYears =
        widget.events.map((event) => event.date.year).toSet().toList();
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.isDesktop(context) ? Spacing.s0 : Spacing.s12,
            horizontal: Responsive.isDesktop(context)
                ? Constants.webHorizontalPadding
                : Constants.mobileHorizontalPadding,
          ),
          child: DefaultTabController(
            length: eventsYears.length,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
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
                  overlayColor: MaterialStateProperty.all(Palette.transparent),
                  physics: const BouncingScrollPhysics(),
                  tabs: eventsYears.map((year) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.isDesktop(context)
                            ? Spacing.l48
                            : Spacing.l24,
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
                  height: Constants.eventsCardHeight,
                  child: TabBarView(
                    children: eventsYears.map((year) {
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: Constants.eventsCardHeight,
                              width: Constants.eventsCardWidth,
                              child: EventCard(
                                event: widget.events
                                    .where((event) => event.date.year == year)
                                    .toList()[index],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: Spacing.s8),
                          itemCount: widget.events
                              .where((event) => event.date.year == year)
                              .length,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
