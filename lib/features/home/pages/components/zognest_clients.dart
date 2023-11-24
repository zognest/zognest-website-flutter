import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
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
              Constants.clientsItemWidth * currentIndex,
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
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? Constants.webHorizontalPadding
                    : Constants.mobileHorizontalPadding,
              ),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.clientFeedbacks.length;
                final clientFeedback = Data.clientFeedbacks[i];
                return ClientItem(clientFeedback: clientFeedback);
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
  });

  final ClientFeedback clientFeedback;

  @override
  State<ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<ClientItem> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FrostedContainer(
      width: Constants.clientsItemWidth -
          (Responsive.isDesktop(context) ? 0 : 100),
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
              child: GreyscaleFilter(
                isHovered: hovered,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            widget.clientFeedback.backgroundImages[0],
                            // height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: Spacing.m16),
                        Expanded(
                          child: Image.asset(
                            widget.clientFeedback.backgroundImages[1],
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: Image.asset(widget.clientFeedback.clientImage),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.m20,
                          vertical: Spacing.m18,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.clientFeedback.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
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
