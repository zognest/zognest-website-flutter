import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../resources/spacing.dart';
import '../../../shared/widgets/network_fading_image.dart';

class ZognestClients extends ConsumerStatefulWidget {
  const ZognestClients({super.key});

  @override
  ConsumerState<ZognestClients> createState() => _ZognestClientsState();
}

class _ZognestClientsState extends ConsumerState<ZognestClients> {
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
    final clientFeedbacks = ref.watch(appControllerProvider).clientFeedbacks;
    return clientFeedbacks.when(
      data: (clientFeedbacks) {
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
                if (_controller.offset ==
                    _controller.position.maxScrollExtent) {
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
                  return ClientItem(clientFeedback: clientFeedbacks[index]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: Constants.listCardSeparatorWidth),
                itemCount: clientFeedbacks.length,
              ),
            ),
            const Divider(),
          ],
        );
      },
      error: (_, __) => const Text('Error'),
      loading: () => CircularProgressIndicator(color: theme.primaryColor),
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
      borderRadius: 20,
      width: Constants.listCardWidth,
      height: double.infinity,
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
            Expanded(
              child: GreyscaleFilter(
                isHovered: hovered,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 48),
                      child: Row(
                        children: [
                          Card(
                            clipBehavior:Clip.antiAliasWithSaveLayer,
                            child: Expanded(
                              flex: 2,
                              child: NetworkFadingImage(
                                 path:widget.clientFeedback.backgroundImages[0],
                                  height: double.infinity ,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.m16),
                          Expanded(
                            child: Card(
                              clipBehavior:Clip.antiAliasWithSaveLayer,
                              child: NetworkFadingImage(
                                path:
                                widget.clientFeedback.backgroundImages[1],
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      child: Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Palette.cardBackgroundColor,
                            width: Spacing.s4,
                          ),
                          image: DecorationImage(
                            image:
                                NetworkImage(widget.clientFeedback.clientImage),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
