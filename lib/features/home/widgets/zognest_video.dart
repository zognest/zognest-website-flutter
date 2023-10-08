import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
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
        strictRelatedVideos: true,
      ),
    )..listen(videoListener);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void videoListener(YoutubePlayerValue event) {
    state = event.playerState;
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: size.height * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.webHorizontalPadding),
                child: YoutubePlayerScaffold(
                  controller: _controller,
                  builder: (context, player) {
                    return player;
                  },
                ),
              ),
              PointerInterceptor(
                child: InkWell(
                  overlayColor: MaterialStateProperty.all(Palette.transparent),
                  onTap: () {
                    if (state == PlayerState.playing) {
                      _controller.pauseVideo();
                      return;
                    }
                    if (state == PlayerState.paused ||
                        state == PlayerState.ended) {
                      _controller.playVideo();
                      return;
                    }
                  },
                  onHover: (over) {
                    if (over && state == PlayerState.cued) {
                      _controller.playVideo();
                    }
                  },
                  child: const SizedBox.expand(),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
