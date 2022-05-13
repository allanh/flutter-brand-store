import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/entities/module/module.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.module,
  }) : super(key: key);
  final Module module;

  @override
  State<StatefulWidget> createState() => _VideoState();
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);
  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    debugPrint('{$controller.value.isPlaying}');
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class _VideoState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.module.youtubeUrl ?? 'cYFcAF4Saw8',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  // _initializeVideoPlayerFuture = _controller.initialize();
  // }
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Complete the code in the next step.
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return Stack(
          children: [
            player,
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: _isPlayerReady
                  ? () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                      setState(() {});
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
