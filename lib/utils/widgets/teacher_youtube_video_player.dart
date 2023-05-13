import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_angels/Controller/videoController.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../animated_navigation.dart';

class TeacherYoutubeVideoPlayer extends StatefulWidget {
  final String? url;
  final int index;
  final String value;
  const TeacherYoutubeVideoPlayer({
    Key? key,
    required this.url,
    required this.index,
    required this.value,
  }) : super(key: key);

  @override
  State<TeacherYoutubeVideoPlayer> createState() => _TeacherYoutubeVideoPlayerState();
}

class _TeacherYoutubeVideoPlayerState extends State<TeacherYoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  var videoController = Get.put(VideoController());
  var entry;
  var student;
  var isVisible = false;

  @override
  void initState() {
    super.initState();
    print(videoController.videos[widget.value][widget.index]["video_description"]);
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
    entry = videoController.videos[widget.value][widget.index];
    student = entry["student"];
   // print("entry "+entry);
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
      backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
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
            player,
            largeSizedBox,
            //Text(entry["video_description"]),
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  entry["video_description"],
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
                  ),
                  smallSizedBox,
                  Text(
                    "Subject: ${widget.value}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  smallerSizedBox,
                  Text(
                    "Class: ${entry["class_name"]}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  largeSizedBox,
                  ElevatedButton(
                    onPressed: () => setState((){
                      isVisible == true ? isVisible = false : isVisible = true;
                    }),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          isVisible == false? Icons.arrow_drop_down: Icons.arrow_drop_up,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        Text(
                          "View Student Details",
                          style:
                          const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  smallSizedBox,
                  Visibility(
                    visible:isVisible,
                    child:SizedBox(
                      width: 400,
                      child:
                      _createDataTable(),
                    )
                  )

                ],
              )
            ),

            //some other widgets
          ],
        );
      },
    ));
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      columnSpacing: 8,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Container(
          width: (MediaQuery.of(context).size.width/4),
          alignment: Alignment.center,
          child: Text('Admision ID',),
        ),
      ),
      DataColumn(label: Container(
        width: (MediaQuery.of(context).size.width / 4),
        alignment: Alignment.center,
        child: Text('Name'),
      ),),
      DataColumn(label: Container(
        width: (MediaQuery.of(context).size.width / 4),
        alignment: Alignment.center,
        child: Text('Email ID'),
      ),)
    ];
  }

  List<DataRow> _createRows() {
    return [
      for(var i=0; i<student.length; i++)
        DataRow(cells: [
          DataCell(
            Container(
              width: (MediaQuery.of(context).size.width / 4),
              alignment: Alignment.center,
              child:Text('${student[i]["admission_id"]}'))),
          DataCell(
            Container(
              width: (MediaQuery.of(context).size.width / 4),
              alignment: Alignment.center,
              child:Text('${student[i]["student_name"]}',))
          ),
          DataCell(
            Container(
              width: (MediaQuery.of(context).size.width / 4),
              alignment: Alignment.center,
              child: TextButton(
                  child: Text('${student[i]["student_email"]}'),
                onPressed: ()async {
              AnimatedNavigation.pushAnimatedNavigation(
              context,
              _launchUrl("mailto:${student[i]["student_email"]}")
              );
              },
              )))
        ]),
    ];
  }
  _launchUrl(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }
}