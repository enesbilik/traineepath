import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../base/base_state.dart';

/// Homepage
class YoutubePlayerCard extends StatefulWidget {
  final String videoId;
  const YoutubePlayerCard({Key? key, required this.videoId}) : super(key: key);

  @override
  _YoutubePlayerCardState createState() => _YoutubePlayerCardState();
}

class _YoutubePlayerCardState extends BaseState<YoutubePlayerCard> {
  late YoutubePlayerController _controller;

  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: _exitFullScreen,
      player: _youtubePlayer(),
      builder: (context, player) {
        return _buildBody(player);
      },
    );
  }

  Widget _buildBody(Widget player) {
    return Column(
      children: [
        player,
        Padding(
          padding: basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              baseSpace0,
              _text('Title', _videoMetaData.title),
              baseSpace0,
              _text('Channel', _videoMetaData.author),
              baseSpace0,
            ],
          ),
        ),
      ],
    );
  }

  YoutubePlayer _youtubePlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      topActions: [
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            _controller.metadata.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: dynamicFontSize(18),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
      onReady: () {
        _isPlayerReady = true;
      },
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextStyle(
          color: kTextColor,
          fontWeight: FontWeight.bold,
          fontSize: dynamicFontSize(15),
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.w300,
              fontSize: dynamicFontSize(14),
            ),
          ),
        ],
      ),
    );
  }

  void _init() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
        captionLanguage: 'tr',
      ),
    )..addListener(_listener);
    _videoMetaData = const YoutubeMetaData();
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void _exitFullScreen() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
}
