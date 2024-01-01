import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/riverpod/controller.dart';

class ZognestVideo extends ConsumerStatefulWidget {
  const ZognestVideo({super.key});

  @override
  ConsumerState<ZognestVideo> createState() => _ZognestVideoState();
}

class _ZognestVideoState extends ConsumerState<ZognestVideo> {
  late VideoPlayerController _controller;
  bool isMusicOn = true;
  bool isPlayOn = true;
  bool isFullScreen = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(''));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = ref.watch(appControllerProvider).videoUrl;
    url.when(
      data: (url) {
        if (_controller.value.isInitialized) return;
        _controller = VideoPlayerController.networkUrl(
          Uri.parse(url),
        )..initialize().then((_) => setState(() {}));
      },
      error: (_, __) {
        print('error');
      },
      loading: () {
        print('loading');
      },
    );
    return Column(
      children: [
        const Divider(),
        VisibilityDetector(
          key: ValueKey(runtimeType.toString()),
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 3) {
              if (_controller.value.isInitialized) _controller.play();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context)
                  ? Constants.webHorizontalPadding
                  : Constants.mobileHorizontalPadding,
            ),
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: Constants.videoAspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller),
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: false,
                          colors: VideoProgressColors(
                            playedColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                    isPlayOn = !isPlayOn;
                                  });
                                },
                                icon: Icon(
                                  isPlayOn == true
                                      ? Icons.play_circle
                                      : Icons.pause_circle,
                                  color: Colors.red,
                                )),
                            const SizedBox(width: 5),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isMusicOn == false
                                        ? _controller.setVolume(1)
                                        : _controller.setVolume(0);
                                    isMusicOn = !isMusicOn;
                                  });
                                },
                                icon: Icon(
                                  isMusicOn == true
                                      ? Icons.volume_up
                                      : Icons.volume_off,
                                  color: Colors.red,
                                )),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  /*   setState(() {
                                isFullScreen == false
                                    ? _controller.value.isCompleted
                                    : _controller.value.
                                isMusicOn = !isMusicOn;
                              });*/
                                },
                                icon: Icon(
                                  isFullScreen == true
                                      ? Icons.fullscreen_sharp
                                      : Icons.fullscreen_exit,
                                  color: Colors.red,
                                )),
                          ],
                        ),


                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
