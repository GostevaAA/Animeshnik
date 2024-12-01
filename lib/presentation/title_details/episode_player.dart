import 'dart:developer';
import 'dart:io';

import 'package:animeshnik/data/models/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';
import 'package:video_player_win/video_player_win_plugin.dart';

class EpisodePlayer extends StatefulWidget {
  const EpisodePlayer({super.key, required this.episode, required this.host});

  final Episode episode;
  final String host;

  @override
  State<EpisodePlayer> createState() => _EpisodePlayerState();
}

class _EpisodePlayerState extends State<EpisodePlayer> {
  late Episode _episode;
  late VideoPlayerController _controller;
  late String host;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    host = widget.host;
    _episode = widget.episode;

    String url = 'https://${host}${_episode.hls.hd}';

    if (!kIsWeb && Platform.isWindows) WindowsVideoPlayer.registerWith();
    _controller = VideoPlayerController.networkUrl(
        //Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
        Uri.parse('https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8'));
    //Uri.parse(url));

    _controller.initialize().then((value) {
      if (_controller.value.isInitialized) {
        _controller.play();
        setState(() {});
      } else {
        log("video file load failed");
      }
    }).catchError((e) {
      log("controller.initialize() error occurs: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: JkVideoControlPanel(
        _controller,
        showClosedCaptionButton: true,
        showFullscreenButton: true,
        showVolumeButton: true,
      ),
    );
  }
}
