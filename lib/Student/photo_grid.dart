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
import 'package:little_angels/utils/widgets/show_image.dart';
import 'package:little_angels/utils/widgets/video_player.dart';
import 'package:little_angels/utils/widgets/youtube_video_player.dart';

import '../utils/widgets/shimmerWidget.dart';

class PhotoGrid extends StatefulWidget {
  final String? id;
  final String? url;

  const PhotoGrid({Key? key, this.id, this.url}) : super(key: key);

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  DateTime todayDate = DateTime.now();
  var image;
  @override
  void initState() {
    image = widget.url!.split(',');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.id!, style: titleTextStyle),
                smallSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      style: textButtonTextStyle,
                    ),
                  ],
                ),
                divider,
                const SizedBox(height: 10),
                buildTabBarView(),
              ],
            ),
          ),
        );
    //   ),
    // );
  }

  buildTabBarView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.40,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
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
                            itemCount: image.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                AnimatedNavigation.pushAnimatedNavigation(
                                  context,
                                  ShowImage(
                                      url: "https://synramtechnology.com/lahs/storage/app/"+image[index]),
                                );
                              },
                              child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  largeSizedBox,
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://synramtechnology.com/lahs/storage/app/"+image[index],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height/6,
                                          width: MediaQuery.of(context).size.width,
                                          placeholder: (context, url) => buildShimmer(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                          ),
                    largeSizedBox,
                  ],
                ),
      ),
    );
  }
  Widget buildShimmer(){
    return Container(
      height: MediaQuery.of(context).size.height/6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorConstants.kWhiteColor,
          borderRadius: BorderRadius.circular(
              10.0)),
      child: Center(
          child: ShimmerWidget.rectangular(height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width,)
      ),
    );
  }
}