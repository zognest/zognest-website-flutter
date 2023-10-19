import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/widgets/scroll_headline.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../../resources/spacing.dart';

class ZognestClients extends StatefulWidget {
  const ZognestClients({super.key});

  @override
  State<ZognestClients> createState() => _ZognestClientsState();
}

class _ZognestClientsState extends State<ZognestClients> {
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
    const itemWidth = 440.0;
    return Column(
      children: [
        const Divider(),
        ScrollHeadline(
          headline: TextSpan(
            children: [
              TextSpan(
                text: '${Strings.happy}\n'.toUpperCase(),
                style: theme.textTheme.displaySmall
                    ?.copyWith(foreground: TextThemes.foreground),
              ),
              TextSpan(
                text: Strings.clients.toUpperCase(),
                style: theme.textTheme.displaySmall,
              ),
            ],
          ),
          onTapScroll: () {
            if (_controller.offset == _controller.position.maxScrollExtent) {
              currentIndex = 0;
            }
            _controller.animateTo(
              itemWidth * currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
            currentIndex++;
          },
        ),
        SizedBox(
          height: Constants.clientsSectionHeight,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.pageHorizontalPadding),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.clientFeedbacks.length;
                final client = Data.clientFeedbacks[i];
                return ClientItem(
                  clientFeedback: client,
                  width: itemWidth,
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

class ClientItem extends StatefulWidget {
  const ClientItem({
    super.key,
    required this.clientFeedback,
    required this.width,
  });

  final ClientFeedback clientFeedback;
  final double width;

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FrostedContainer(
      width: widget.width,
      height: Constants.clientsSectionHeight,
      padding: const EdgeInsets.symmetric(
          horizontal: Spacing.l32, vertical: Spacing.l24),
      child: InkWell(
        onTap: () {},
        onHover: (over) {
          setState(() => hovered = !hovered);
        },
        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Constants.clientsSectionHeight * 0.5,
              child: Stack(
                children: [
                  Row(
                    children: [
                      GreyscaleFilter(
                        isHovered: hovered,
                        child: Image.asset(
                            widget.clientFeedback.backgroundImages[0]),
                      ),
                      const SizedBox(width: Spacing.m16),
                      GreyscaleFilter(
                        isHovered: hovered,
                        child: Image.asset(
                            widget.clientFeedback.backgroundImages[1]),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    bottom: 0,
                    child: GreyscaleFilter(
                      isHovered: hovered,
                      child: Image.asset(widget.clientFeedback.clientImage),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.clientFeedback.name,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.clientFeedback.id,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Palette.white,
                        child: Icon(
                          Icons.play_arrow,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: Spacing.s12),
                      PrimaryButton(
                        title: Strings.view.toUpperCase(),
                        filled: false,
                        padding: const EdgeInsets.all(Spacing.s12),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Text(
                    widget.clientFeedback.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
