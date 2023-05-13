import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/videoController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/video_player.dart';
import 'package:little_angels/utils/widgets/youtube_video_player.dart';

class Video extends StatefulWidget {
  final String? id;
  final String? name;
  const Video({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  DateTime todayDate = DateTime.now();
  var videoController = Get.put(VideoController());
  NetworkHandler nr = NetworkHandler();
  var isSearch = false;
  TextEditingController searchController = TextEditingController();
  var searchText;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      videoController.getStuVideos();
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
  List<Tab> tabMaker(){  //return type is specified

    List<Tab> tabs = []; //create an empty list of Tab
    for (var i = 0; i < videoController.videos.length; i++) {
      tabs.add(Tab(text: videoController.videos[i])); //add your tabs to the list
    }
    return tabs; //return the list
  }

  get betterPlayerConfiguration => null;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Obx(
            () => videoController.isLoading ==true?
        Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
            )
        ): DefaultTabController(
        length: videoController.videos.length,
        child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("VIDEO", style: titleTextStyle),
                smallSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: textButtonTextStyle,
                    ),
                    SizedBox(width: 10,),
                    IconButton(onPressed: (){
                          setState((){
                            isSearch == true? isSearch = false : isSearch = true;
                          });
                        }, icon: SvgPicture.asset(AssetImages.search, height: 25))
                  ],
                ),

                divider,
                const SizedBox(height: 10),
                Visibility(
                  visible: isSearch,
                  child: TextField(
                      onChanged: (text) {
                        print('First text field: $text');
                        for (var entry in videoController.videos.entries){
                          for (var videoentry in entry.value){
                            if(videoentry["video_description"].contains(text)){

                            }
                          }
                        }
                        setState((){
                          searchText = text;
                        });
                        checkSearch(text);
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        hintText: ("Search"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        isDense: true,
                      )),),
                const SizedBox(height: 10),
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
        )));
    //   ),
    // );
  }
  checkSearch(String serach){
    for (var entry in videoController.videos.entries){
      for (var videoentry in entry.value){
        if(videoentry["video_description"].contains(serach)){
          print(videoentry["video_description"]);
          print("search found");
        }
      }
    }
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
        ):Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: TabBarView(
          key: ValueKey(DateTime.now().toString()),
          //physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var entry in videoController.videos.entries)
              if(searchText == "" || searchText == null)...{
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
                                  YoutubeVideoPlayer(
                                      url: entry.value[index]["video_link"],
                                      desc: entry.value[index]["video_description"],
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
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: 'https://img.youtube.com/vi/${entry.value[index]["video_link"].substring(entry.value[index]["video_link"].length -11)}/0.jpg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height/7.8,
                                          width: MediaQuery.of(context).size.width,
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
                ),}else...{
                ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      //childAspectRatio: 16 / 9,
                    ),
                    children: [
                      for (var videoentry in entry.value)...{
                        if(videoentry["video_description"].contains(searchText))...{
                          InkWell(
                              onTap: () {
                                AnimatedNavigation.pushAnimatedNavigation(
                                  context,
                                  YoutubeVideoPlayer(
                                    url: videoentry["video_link"],
                                    desc: videoentry["video_description"],
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
                                    "${videoentry["video_description"]}",
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
                          )
                        }
                      }
                    ],),
                    /*GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        //childAspectRatio: 16 / 9,
                      ),
                      itemCount: entry.value.length,
                      itemBuilder: (context, index) => entry.value[index]["video_description"].contains(searchText)?InkWell(
                          onTap: () {
                            AnimatedNavigation.pushAnimatedNavigation(
                              context,
                              YoutubeVideoPlayer(
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
                      ):Visibility(
                          visible: false,
                          child:SizedBox()),
                    ),*/
                    largeSizedBox,
                    divider,
                  ],
                ),
              }
          ],
        ),
      ),
    ));
  }
}