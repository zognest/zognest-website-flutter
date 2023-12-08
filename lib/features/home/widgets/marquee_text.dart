import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/resources/strings.dart';

import '../../../../config/constants.dart';
import '../../../config/responsive.dart';

class MarqueeText extends StatefulWidget {
  const MarqueeText({super.key});

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;

  double offset = 0.0;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..addListener(animationListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.removeListener(animationListener);
    _animationController.dispose();
    super.dispose();
  }

  void animationListener() {
    if (_animationController.isCompleted) _animationController.repeat();
    offset += 1.0;
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final marqueeText = [
      Text(
        Strings.weAreTheCre.toUpperCase(),
        style: theme.textTheme.displaySmall?.copyWith(
          foreground: TextThemes.foreground,
          letterSpacing: 3,
        ),
      ),
      Stack(
        children: [
          Text(
            Strings.eight.toUpperCase(),
            style: theme.textTheme.displaySmall
                ?.copyWith(color: theme.primaryColor),
          ),
          Text(
            Strings.eight.toUpperCase(),
            style: theme.textTheme.displaySmall
                ?.copyWith(foreground: TextThemes.foreground),
          ),
        ],
      ),
      Text(
        Strings.tive.toUpperCase(),
        style: theme.textTheme.displaySmall?.copyWith(
          foreground: TextThemes.foreground,
          letterSpacing: 3,
        ),
      ),
    ];
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: Responsive.isDesktop(context) ? Constants.marqueeHeight : 100,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final i = index % marqueeText.length;
              return marqueeText[i];
            },
          ),
        ),
        const Divider(),
      ],
    );
  }
}
