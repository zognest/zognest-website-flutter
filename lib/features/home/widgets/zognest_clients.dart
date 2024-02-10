import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';
import 'package:just_audio/just_audio.dart';
import '../../../resources/spacing.dart';
import '../../../shared/widgets/network_fading_image.dart';

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
        Consumer(builder: (context, ref, child) {
          final clientFeedbacks =
              ref.watch(appControllerProvider).clientFeedbacks;
          return clientFeedbacks.when(
            data: (clientFeedbacks) {
              return SizedBox(
                height: Constants.listHeight,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return ClientItem(clientFeedback: clientFeedbacks[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: Constants.listCardSeparatorWidth),
                  itemCount: clientFeedbacks.length,
                ),
              );
            },
            error: (_, __) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
          );
        }),
        const Divider(),
      ],
    );
  }
}

class ClientItem extends HookWidget {
  const ClientItem({
    super.key,
    required this.clientFeedback,
  });

  final ClientFeedback clientFeedback;

  @override
  Widget build(BuildContext context) {
    final isPlaying = useState(false);
    final hovering = useState(false);
    final audioPlayer = useState(AudioPlayer());
    useEffect(() {
      audioPlayer.value.setUrl(clientFeedback.audioUrl);
      return audioPlayer.value.dispose;
    }, []);
    final theme = Theme.of(context);
    return FrostedContainer(
      borderRadius: 20,
      width: Constants.listCardWidth,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: Spacing.l32, vertical: Spacing.l24),
      child: InkWell(
        onTap: () {},
        onHover: (over) => hovering.value = over,
        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GreyscaleFilter(
                isHovered: hovering.value,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 48),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              child: NetworkFadingImage(
                                path: clientFeedback.backgroundImages[0],
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.s8),
                          Expanded(
                            flex: 2,
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              child: NetworkFadingImage(
                                path: clientFeedback.backgroundImages[1],
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
                            image: NetworkImage(clientFeedback.clientImage),
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
                            clientFeedback.name,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            clientFeedback.id,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Palette.white,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(
                            isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow_rounded,
                          ),
                          color: theme.primaryColor,
                          onPressed: () {
                            isPlaying.value
                                ? audioPlayer.value.pause()
                                : audioPlayer.value.play();
                            isPlaying.value = !isPlaying.value;
                          },
                        ),
                      ),
                      const SizedBox(width: Spacing.s12),
                      PrimaryButton(
                        height: 40,
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
                        clientFeedback.description,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontFamily: 'SF Pro Rounded',
                        ),
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
