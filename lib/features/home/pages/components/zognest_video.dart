import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/shared/data.dart';

class ZognestVideo extends StatefulWidget {
  const ZognestVideo({super.key});

  @override
  State<ZognestVideo> createState() => _ZognestVideoState();
}

class _ZognestVideoState extends State<ZognestVideo> {
  late final YoutubePlayerController _controller;
  PlayerState state = PlayerState.unknown;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: Data.ytVideoUrl,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: false,
        showFullscreenButton: true,
      ),
    )
      ..update(playbackQuality: 'HD')
      ..listen(videoListener);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void videoListener(YoutubePlayerValue event) => state = event.playerState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        VisibilityDetector(
          key: ValueKey(runtimeType.toString()),
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 2 && state == PlayerState.cued) {
              _controller.playVideo();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.webHorizontalPadding),
            child: Stack(
              alignment: Alignment.center,
              children: [
                YoutubePlayerScaffold(
                  controller: _controller,
                  aspectRatio: Constants.videoAspectRatio,
                  builder: (_, player) => player,
                ),
                PointerInterceptor(
                  child: InkWell(
                    overlayColor:
                        MaterialStateProperty.all(Palette.transparent),
                    onTap: () {
                      if (state == PlayerState.playing) {
                        _controller.pauseVideo();
                        return;
                      }
                      if (state == PlayerState.paused ||
                          state == PlayerState.ended ||
                          state == PlayerState.cued) {
                        _controller.playVideo();
                      }
                    },
                    child: const AspectRatio(
                      aspectRatio: Constants.videoAspectRatio,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
