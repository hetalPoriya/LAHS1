// ignore_for_file: unused_import, prefer_const_constructors

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/upload_video.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/teacher_youtube_video_player.dart';
import 'package:little_angels/utils/widgets/video_player.dart';

import '../Controller/videoController.dart';
import '../utils/network_handler.dart';
import '../utils/widgets/youtube_video_player.dart';

class TeacherVideo extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherVideo({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherVideo> createState() => _TeacherVideoState();
}

class _TeacherVideoState extends State<TeacherVideo> {
  DateTime todayDate = DateTime.now();
  final List<Map<String, dynamic>> _data = [
    {
      'image': AssetImages.php,
      'icon': AssetImages.videoIcon,
    },
    {
      'image': AssetImages.php,
      'icon': AssetImages.videoIcon,
    },
  ];

  var videoController = Get.put(VideoController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      videoController.getTeacherVideos();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
    }
  }

  get betterPlayerConfiguration => null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(90),
              //bottomRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.video1),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Obx(
          () => videoController.isLoading ==true?
          Center(
          child: Image.asset(
          "assets/loading.gif",
          height: 425.0,
          width: 425.0,
          fit: BoxFit.fitHeight,
          )
          ):DefaultTabController(
            length: videoController.videos.length,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 10, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  smallSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("VIDEOS", style: titleTextStyle),
                      // SvgPicture.asset(AssetImages.search, height: 25),
                      ElevatedButton(
                        onPressed: () =>
                            AnimatedNavigation.pushAnimatedNavigation(
                                context, UploadVideo()),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: Colors.deepPurple,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "Add new video",
                              style:
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  divider,
                  smallSizedBox,
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: videoController.status == "Videos not found"?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/no-data.gif"),
                        smallSizedBox,
                        Text("No Videos Found", style: TextStyle(color: Colors.purple[800]),)
                      ],
                    )
                        : TabBar(
                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        for (var entry in videoController.videos.entries)
                          Tab(
                            text: entry.key,
                          )
                      ],
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: Color.fromARGB(255, 238, 220, 241),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      indicatorPadding:
                      EdgeInsets.only(top: 8, bottom: 10, left: 4, right: 4),
                      labelColor: ColorConstants.kHeadingTextColor,
                      labelStyle: TextStyle(fontSize: 15),
                      unselectedLabelColor: ColorConstants.kBlackColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  videoController.status == "Videos not found"? SizedBox(): buildTabBarView(),
                ],
              ),
            ),
          )),
      ),
    );
    //   ),
    // );
  }

  buildTabBarView() {
    return Obx(
            () => videoController.isLoading ==true?
        Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
            )
        ):SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.60,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: TabBarView(
              key: ValueKey(DateTime.now().toString()),
              //physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var entry in videoController.videos.entries)
                  ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          //childAspectRatio: 16 / 9,
                        ),
                        itemCount: entry.value.length,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              AnimatedNavigation.pushAnimatedNavigation(
                                context,
                                TeacherYoutubeVideoPlayer(
                                  url: entry.value[index]["video_link"],
                                  index: index,
                                  value: entry.key,
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                largeSizedBox,
                                Text(
                                  "${entry.value[index]["video_description"]}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                largeSizedBox,
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        AssetImages.english,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Image.asset(
                                      AssetImages.videoIcon,
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                      ),
                      largeSizedBox,
                      divider,
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
