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
            if (info.visibleFraction >= 2) {
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
                  IconButton(
                    onPressed: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.red,
                    ),
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: false,
                    colors: VideoProgressColors(
                      playedColor: Theme.of(context).primaryColor,
                    ),
                  )
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
