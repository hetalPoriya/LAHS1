import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Controller/videoController.dart';
import '../colors.dart';
import '../images.dart';
import '../utility.dart';

class VideoPlayer extends StatefulWidget {
  final String? url;
  VideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<VideoPlayer> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url!)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,

                // progressColors: ProgressColors(
                //     playedColor: Colors.amber,
                //     handleColor: Colors.amberAccent,
                // ),
                onReady: () {
                  _controller.addListener(listener);
                },
              ),
              builder: (context, player) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // some widgets
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: ColorConstants.kTransparentColor,
                            highlightColor: ColorConstants.kTransparentColor,
                            onTap: () => Navigator.of(context).pop(),
                            child: Image.asset(
                              AssetImages.back,
                              width: 60.0,
                              height: 60.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 15),
                            child: Text("VIDEO PLAYER", style: TextStyle(
                              fontSize: 25.0,
                              color: ColorConstants.kHeadingTextColor,
                              fontWeight: kFontWeight900,
                            )),),
                          smallSizedBox,
                          divider,
                        ],
                      ),),
                    player,
                    largeSizedBox,
                  ],
                );
              },
            ))
    );
  }
}