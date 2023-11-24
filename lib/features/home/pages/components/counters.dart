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

class Counters extends StatelessWidget {
  const Counters({super.key});

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
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    const CountElement(
                      count: 09,
                      title: Strings.appDevelopment,
                    ),
                    const RowDivider(),
                    const CountElement(
                      count: 12,
                      title: Strings.webDevelopment,
                    ),
                    if (Responsive.isDesktop(context)) const RowDivider(),
                    const CountElement(
                      count: 17,
                      title: Strings.uiUxForCompanies,
                    ),
                    const RowDivider(),
                    const CountElement(
                      count: 36,
                      title: Strings.happyCustomer,
                    ),
                    if (Responsive.isDesktop(context)) const RowDivider(),
                    if (Responsive.isMobile(context))
                      const Align(
                        alignment: Alignment.center,
                        child: CountElement(
                          count: 36,
                          title: Strings.projectsCompleted,
                          hasPlus: false,
                        ),
                      ),
                    if (!Responsive.isMobile(context))
                      const CountElement(
                        count: 36,
                        title: Strings.projectsCompleted,
                        hasPlus: false,
                      ),
                  ],
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

class CountElement extends StatefulWidget {
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
}
