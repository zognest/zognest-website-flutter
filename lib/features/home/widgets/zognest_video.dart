import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/riverpod/controller.dart';

class ZognestVideo extends StatefulWidget {
  const

  ZognestVideo({super.key});

  @override
  State<ZognestVideo> createState() => _ZognestVideoState();
}

class _ZognestVideoState extends State<ZognestVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(''),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        Consumer(
          builder: (context, ref, child) {
            final url = ref.watch(appControllerProvider).videoUrl;
            return url.when(
              data: (url) {
                if (!_controller.value.isInitialized) {
                  _controller = VideoPlayerController.networkUrl(
                    Uri.parse(url),
                  )..initialize().then((_) => setState(() {}));
                }
                return VisibilityDetector(
                  key: ValueKey(runtimeType.toString()),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction >= 0.7) {
                      if (_controller.value.isInitialized) _controller.play();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPaddingViduo),
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: Responsive.isDesktop(context)
                                ? Constants.videoAspectRatio
                                : Constants.videoAspectRatioMobile,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(_controller),
                                SizedBox.expand(
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    VideoProgressIndicator(
                                      _controller,
                                      colors: VideoProgressColors(
                                        playedColor: theme.primaryColor,
                                      ),
                                      allowScrubbing: false,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _controller.value.isPlaying
                                                ? _controller.pause()
                                                : _controller.play();
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            _controller.value.isPlaying
                                                ? Icons.pause_rounded
                                                : Icons.play_arrow_rounded,
                                            color: theme.primaryColor,
                                            size: 34,
                                          ),
                                        ),
                                        const SizedBox(width: Spacing.s8),
                                        IconButton(
                                          onPressed: () {
                                            _controller.value.volume == 0
                                                ? _controller.setVolume(1)
                                                : _controller.setVolume(0);
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            _controller.value.volume == 0
                                                ? Icons.volume_off_rounded
                                                : Icons.volume_up_rounded,
                                            // color: theme.primaryColor,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: Spacing.m16),
                                        StreamBuilder(
                                          stream: Stream.periodic(
                                              const Duration(seconds: 1)),
                                          builder: (_, __) {
                                            return Text(
                                              '${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}',
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
              error: (_, __) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}