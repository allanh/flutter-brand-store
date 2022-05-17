import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../pages/home/home_controller.dart';

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

class _VideoState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.module.youtubeUrl ?? ' ',
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

  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   // _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Complete the code in the next step.
    final theme = Theme.of(context);
    final controller =
        FlutterCleanArchitecture.getController<HomeController>(context);
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
        return Column(
          children: [
            Stack(
              children: [
                player,
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
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
            ),
            (widget.module.showYoutubeTitle ?? false)
                ? GestureDetector(
                    onTap: () => controller.onTap(widget.module.link),
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 32.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.module.youtubeTitle ?? 'title',
                              style: theme.textTheme.caption?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const Text(
                              '>',
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
