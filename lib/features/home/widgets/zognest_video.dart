import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';

class ZognestVideo extends StatefulWidget {
  const ZognestVideo({super.key});

  @override
  State<ZognestVideo> createState() => _ZognestVideoState();
}

class _ZognestVideoState extends State<ZognestVideo> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/videos%2Fmarketing%2Ftest_video.mp4?alt=media&token=27ee09f9-9aa6-42b4-8c9f-ead614b96bf5',
      ),
    )..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        VisibilityDetector(
          key: ValueKey(runtimeType.toString()),
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 2) {
              // play
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
