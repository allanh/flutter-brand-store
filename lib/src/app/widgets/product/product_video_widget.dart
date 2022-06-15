import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../pages/home/home_controller.dart';

import '../../../domain/entities/module/module.dart';

class ProudctVideoWidget extends StatefulWidget {
  const ProudctVideoWidget({
    Key? key,
    required this.module,
  }) : super(key: key);
  final Module module;

  @override
  State<StatefulWidget> createState() => _ProudctVideoWidgetState();
}

class _ProudctVideoWidgetState extends State<ProudctVideoWidget> {
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
    return SizedBox.shrink();
  }
}
