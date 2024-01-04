import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/row_divider.dart';

class Counters extends StatefulWidget {
  const Counters({super.key});

  @override
  State<Counters> createState() => _CountersState();
}

class _CountersState extends State<Counters>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: Constants.countersAnimationDuration),
    );
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
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.025),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return RadialGradient(
                          colors: [
                            Palette.white.withOpacity(0.5),
                            theme.scaffoldBackgroundColor,
                          ],
                          radius: 3.8,
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        );
                      },
                      child: Text(
                        Strings.someCountThatMatters.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: theme.textTheme.displayLarge?.copyWith(
                          foreground: TextThemes.foreground,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isDesktop(context)
                          ? Constants.webHorizontalPadding
                          : Constants.mobileHorizontalPadding,
                    ),
                    child: FittedBox(
                      child: Text(
                        Strings.someCountThatMatters.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.primaryColor,
                          fontSize: Responsive.isDesktop(context) ? 42 : 18,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? Constants.webHorizontalPadding
                      : Constants.mobileHorizontalPadding,
                ),
                child: VisibilityDetector(
                  key: ValueKey(runtimeType.toString()),
                  onVisibilityChanged: (info) {
                    if (_controller.isCompleted) return;
                    if (info.visibleFraction == 1) _controller.forward();
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CounterItem(
                        count: 09,
                        title: Strings.appDevelopment,
                        controller: _controller,
                      ),
                      const RowDivider(),
                      CounterItem(
                        count: 12,
                        title: Strings.webDevelopment,
                        controller: _controller,
                      ),
                      if (Responsive.isDesktop(context)) const RowDivider(),
                      CounterItem(
                        count: 17,
                        title: Strings.uiUxForCompanies,
                        controller: _controller,
                      ),
                      const RowDivider(),
                      CounterItem(
                        count: 36,
                        title: Strings.happyCustomer,
                        controller: _controller,
                      ),
                      if (Responsive.isDesktop(context)) const RowDivider(),
                      if (Responsive.isMobile(context))
                        Align(
                          alignment: Alignment.center,
                          child: CounterItem(
                            count: 36,
                            title: Strings.projectsCompleted,
                            hasPlus: false,
                            controller: _controller,
                          ),
                        ),
                      if (!Responsive.isMobile(context))
                        CounterItem(
                          count: 36,
                          title: Strings.projectsCompleted,
                          hasPlus: false,
                          controller: _controller,
                        ),
                    ],
                  ),
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

class CounterItem extends StatelessWidget {
  const CounterItem({
    super.key,
    required this.count,
    required this.title,
    this.hasPlus = true,
    required this.controller,
  });

  final int count;
  final String title;
  final bool hasPlus;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Responsive.isDesktop(context)
          ? Constants.webCountItemHeight
          : Constants.mobileCountItemHeight,
      width: Responsive.isDesktop(context) ? 220 : 190,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,

              textBaseline: TextBaseline.alphabetic,
              children: [
                Countup(
                  animationController: controller,
                  begin: 0,
                  end: count.toDouble(),
                  separator: ',',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.primaryColor,
                    fontSize: Responsive.isMobile(context) ? 25 : null,
                    height: .5,
                  ),
                ),
                if (hasPlus)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '+',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: Responsive.isMobile(context) ? 15 : 60,
                        color: theme.primaryColor,
                        height: .8,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.s8),
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: theme.textTheme.labelLarge
                ?.copyWith(fontSize: Responsive.isDesktop(context) ? null : 10),
          ),
        ],
      ),
    );
  }
}

/*class CountElement extends StatefulWidget {
  const CountElement({
    super.key,
    required this.count,
    required this.title,
    this.hasPlus = true,
  });

  final int count;
  final String title;
  final bool hasPlus;

  @override
  State<CountElement> createState() => _CountElementState();
}

class _CountElementState extends State<CountElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: Constants.countersAnimationDuration),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Responsive.isDesktop(context)
          ? Constants.webCountItemHeight
          : Constants.mobileCountItemHeight,
      width: Responsive.isDesktop(context) ? 220 : 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: VisibilityDetector(
              key: Key(widget.title),
              onVisibilityChanged: (info) {
                if (_controller.isCompleted) return;
                if (info.visibleFraction == 1) _controller.forward();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Countup(
                    animationController: _controller,
                    begin: 0,
                    end: widget.count.toDouble(),
                    separator: ',',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.primaryColor,
                      fontSize: Responsive.isMobile(context) ? 40 : null,
                      height: 1,
                    ),
                  ),
                  if (widget.hasPlus)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '+',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: Responsive.isMobile(context) ? 20 : 60,
                          color: theme.primaryColor,
                          height: 1,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.s12),
          Text(
            widget.title.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: theme.textTheme.labelLarge
                ?.copyWith(fontSize: Responsive.isDesktop(context) ? null : 12),
          ),
        ],
      ),
    );
  }
}*/
