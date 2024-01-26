import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';
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
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: Constants.marqueeHeight *
              (Responsive.isDesktop(context) ? 1 : 0.5),
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 14),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: theme.textTheme.displaySmall,
                    children: [
                      TextSpan(
                        text: Strings.weAreThe.toUpperCase(),
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF222222),
                        ),
                      ),
                      TextSpan(
                        text:Strings.creative.toUpperCase(),
                        style: theme.textTheme.displaySmall?.copyWith(
                          color:Palette.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(),
      ],
    );
  }
}
