import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_angels/Controller/dailyActivityController.dart';
import 'package:little_angels/Student/message.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/custom_drawer.dart';
import 'package:little_angels/utils/widgets/shimmerWidget.dart';

import '../../Student/notification.dart';
import '../animated_navigation.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool automaticallyImplyLeading;
  final scaffoldKey;
  final Widget? titleWidget;

  CustomAppBar({
    Key? key,
    this.scaffoldKey,
    this.titleWidget,
    this.automaticallyImplyLeading = false,
  }) : super(key: key);
  var dailyActivityController = Get.put(DailyActivityController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          leading: automaticallyImplyLeading
              ? IconButton(
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                  icon: SvgPicture.asset(
                    AssetImages.drawerBurgarMenu,
                    height: 30,
                    width: 30,
                    fit: BoxFit.scaleDown,
                  ),
                )
              : null,
          leadingWidth: 50.0,
          centerTitle: false,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: automaticallyImplyLeading
              ? null
              : Row(
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
                    if (titleWidget != null) ...[
                      titleWidget!,
                    ],
                  ],
                ),
          backgroundColor: ColorConstants.kTransparentColor,
          elevation: 0,
          actions: [
            automaticallyImplyLeading
                ? Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 8.0),
                    child: GestureDetector(
                        onTap: () {
                          dailyActivityController
                              .stuUpdateCounter("notification");
                          dailyActivityController.notification(0);
                          AnimatedNavigation.pushAnimatedNavigation(
                              context, const Notifications());
                        },
                        child: Obx(() => badge.Badge(
                              badgeContent: SizedBox(
                                  width: 12, //height: 10, //badge size
                                  child: Center(
                                    //aligh badge content to center
                                    child: Text(
                                        "${dailyActivityController.notification}",
                                        style: TextStyle(
                                            color:
                                                Colors.white, //badge font color
                                            fontSize: 10 //badge font size
                                            )),
                                  )),
                              showBadge:
                                  dailyActivityController.notification != 0
                                      ? true
                                      : false,
                              child: SvgPicture.asset(
                                AssetImages.drawerFeeds,
                                color: Colors.black,
                                height: 22,
                                width: 22,
                              ),
                            ))))
                : SizedBox(),
            automaticallyImplyLeading
                ? Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 8.0),
                    child: GestureDetector(
                        onTap: () {
                          dailyActivityController.stuUpdateCounter("message");
                          dailyActivityController.messageCount(0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Message(
                                      name: "Message",
                                    )),
                          );
                        },
                        child: Obx(() => badge.Badge(
                              badgeContent: SizedBox(
                                  width: 12, //height: 10, //badge size
                                  child: Center(
                                    //aligh badge content to center
                                    child: Text(
                                        "${dailyActivityController.messageCount}",
                                        style: TextStyle(
                                            color:
                                                Colors.white, //badge font color
                                            fontSize: 10 //badge font size
                                            )),
                                  )),
                              showBadge:
                                  dailyActivityController.messageCount != 0
                                      ? true
                                      : false,
                              child: Image.asset(
                                AssetImages.messages,
                                height: 32,
                                width: 32,
                                color: Colors.black,
                              ),
                            ))))
                : SizedBox(),
            // InkWell(
            //   splashColor: ColorConstants.kTransparentColor,
            //   highlightColor: ColorConstants.kTransparentColor,
            //   onTap: () {
            //     dailyActivityController.stuUpdateCounter("message");
            //     dailyActivityController.messageCount(0);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const Message(
            //                 name: "Message",
            //               )),
            //     );
            //   },
            //   child: Padding(
            //       padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
            //       child: Container(
            //         // decoration: BoxDecoration(
            //         //   gradient: const LinearGradient(
            //         //       colors: [Colors.red, Color(0xFFEF9A9A)]),
            //         //   borderRadius: containeBorderRadius,
            //         // ),
            //         child: Obx(() => dailyActivityController.isLoading.value
            //             ? ShimmerWidget.rectangular(
            //                 width: MediaQuery.of(context).size.width,
            //                 height: MediaQuery.of(context).size.height,
            //               )
            //             : Badge(
            //                 showBadge: dailyActivityController.messageCount != 0
            //                     ? true
            //                     : false,
            //                 badgeContent: SizedBox(
            //                     width: 20, //height: 20, //badge size
            //                     child: Center(
            //                       //aligh badge content to center
            //                       child: Text(
            //                           "${dailyActivityController.messageCount}",
            //                           style: TextStyle(
            //                               color:
            //                                   Colors.white, //badge font color
            //                               fontSize: 20 //badge font size
            //                               )),
            //                     )),
            //                 child: SvgPicture.asset(
            //                   AssetImages.drawerMessages,
            //                   color: Colors.black,
            //                   height: 25,
            //                   width: 25,
            //                 ),
            //                 // child: Column(
            //                 //   mainAxisAlignment: MainAxisAlignment.center,
            //                 //   children: [
            //                 //     Image.asset(
            //                 //       AssetImages.messages,
            //                 //       width: 50.0,
            //                 //       height: 50.0,
            //                 //     ),
            //                 //     Text(
            //                 //       "Messages",
            //                 //       maxLines: 1,
            //                 //       textAlign: TextAlign.center,
            //                 //       style: buttonTextStyle,
            //                 //     ),
            //                 //   ],
            //                 // ),
            //               )),
            //       )),
            // ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72.0);
}
