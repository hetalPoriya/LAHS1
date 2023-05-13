// // ignore_for_file: unused_import
// import 'package:badges/badges.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:little_angels/Student/activities.dart';
// import 'package:little_angels/Student/assignments.dart';
// import 'package:little_angels/Student/attendance.dart';
// import 'package:little_angels/Student/activity_details.dart';
// import 'package:little_angels/Student/document.dart';
// import 'package:little_angels/Student/feeds.dart';
// import 'package:little_angels/Student/message.dart';
// import 'package:little_angels/Student/my_profile.dart';
// import 'package:little_angels/Student/notification.dart';
// import 'package:little_angels/Student/pickupcard.dart';
// import 'package:little_angels/Student/video.dart';
// import 'package:little_angels/Student/view_events.dart';
// import 'package:little_angels/Student/profile_page.dart';
// import 'package:little_angels/Student/todays_work.dart';
// import 'package:little_angels/utils/animated_navigation.dart';
// import 'package:little_angels/utils/colors.dart';
// import 'package:little_angels/utils/constants.dart';
// import 'package:little_angels/utils/widgets/custom_app_bar.dart';
// import 'package:little_angels/utils/widgets/custom_drawer.dart';
// import 'package:little_angels/utils/widgets/custom_page.dart';
// import 'package:little_angels/utils/images.dart';
// import 'package:little_angels/utils/strings.dart';
// import 'package:little_angels/utils/utility.dart';
// import 'package:little_angels/utils/widgets/shimmerWidget.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../Controller/dailyActivityController.dart';
// import '../Controller/loginController.dart';
// import '../utils/network_handler.dart';
//
// class StudentHome extends StatefulWidget {
//   final String? id;
//   final String? name;
//
//   const StudentHome({Key? key, this.id, this.name}) : super(key: key);
//
//   @override
//   State<StudentHome> createState() => _StudentHomeState();
// }
//
// class _StudentHomeState extends State<StudentHome>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   DateTime todayDate = DateTime.now();
//
//   //final DateFormat formatter = DateFormat('EEEE');
//   // final DateFormat formatter1 = DateFormat('dMMMM');
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   var loginController = Get.put(LoginController());
//   var dailyActivityController = Get.put(DailyActivityController());
//
//   final List<Map<String, dynamic>> _data = [
//     {
//       'title': "Today's Work",
//       'icon': AssetImages.todaysWork,
//       'color': const LinearGradient(colors: [Colors.orange, Color(0xFFFFCC80)]),
//       'page': const TodaysWork(
//         name: "Today's Work",
//       )
//     },
//     {
//       'title': "Video",
//       'icon': AssetImages.video,
//       'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
//       'page': const Video(
//         name: "Video",
//       )
//     },
//     {
//       'title': "Messages",
//       'icon': AssetImages.messages,
//       'color': const LinearGradient(colors: [Colors.red, Color(0xFFEF9A9A)]),
//       'page': const Message(
//         name: "Message",
//       )
//     },
//     {
//       'title': "Assignments",
//       'icon': AssetImages.messageAssignment,
//       'color': const LinearGradient(colors: [Colors.blue, Color(0xFF90CAF9)]),
//       'page': const Assignments(
//         name: "Assignments",
//       )
//     },
//     {
//       'title': "Attendance",
//       'icon': AssetImages.drawerAttendence,
//       'color':
//           const LinearGradient(colors: [Colors.deepPurple, Color(0xFFB39DDB)]),
//       'page': const Attendance(
//         name: "Attendance",
//       )
//     },
//     {
//       'title': "View Events",
//       'icon': AssetImages.assessmentCert,
//       'color': const LinearGradient(colors: [Colors.pink, Color(0xFFF48FB1)]),
//       'page': const ViewEvents(
//         name: "View Events",
//       )
//     },
//     {
//       'title': "Feeds",
//       'icon': AssetImages.newsFeeds,
//       'color': const LinearGradient(colors: [Colors.orange, Color(0xFFFFCC80)]),
//       'page': const Feeds()
//     },
//     {
//       'title': "Documents",
//       'icon': AssetImages.documents,
//       'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
//       'page': const Documents()
//     },
//     {
//       'title': "Pickup Card",
//       'icon': AssetImages.drawerPickUpCard,
//       'color': const LinearGradient(colors: [Colors.red, Color(0xFFEF9A9A)]),
//       'page': const Pickupcard()
//     },
//   ];
//
//   final ScrollController scrollController = ScrollController();
//   bool showBar = true;
//   NetworkHandler nr = NetworkHandler();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _tabController = new TabController(length: 2, vsync: this);
//     _init();
//     super.initState();
//     checkScroll();
//   }
//
//   _init() async {
//     bool isConnected = await nr.checkConnectivity();
//     print(isConnected);
//     if (isConnected) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         dailyActivityController.getStuActivity();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         duration: Duration(days: 1),
//         behavior: SnackBarBehavior.floating,
//         content: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               Icons.signal_wifi_off,
//               color: Colors.white,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 16.0,
//                 ),
//                 child: Text(
//                   'No internet available',
//                   textAlign: TextAlign.start,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         action: SnackBarAction(
//             textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
//         backgroundColor: Colors.grey,
//       ));
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     scrollController.removeListener(() {});
//     super.dispose();
//   }
//
//   checkScroll() async {
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent > 120.0 &&
//           scrollController.position.userScrollDirection ==
//               ScrollDirection.reverse) {
//         setState(() {
//           showBar = false;
//         });
//       } else if (scrollController.position.userScrollDirection ==
//           ScrollDirection.forward) {
//         setState(() {
//           showBar = true;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     MediaQuery gridView() => MediaQuery.removePadding(
//           removeTop: true,
//           context: context,
//           child: GridView(
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 15,
//               crossAxisSpacing: 10,
//               childAspectRatio: 1,
//             ),
//             children: [
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const TodaysWork(
//                               name: "Today's Work",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.orange, Color(0xFFFFCC80)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.todaysWork,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Today's Work",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const Video(
//                               name: "Video",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.green, Color(0xFFA5D6A7)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.video,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Video",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   dailyActivityController.stuUpdateCounter("message");
//                   dailyActivityController.messageCount(0);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const Message(
//                               name: "Message",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.red, Color(0xFFEF9A9A)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(() => dailyActivityController.isLoading.value
//                           ? ShimmerWidget.rectangular(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height,
//                             )
//                           : Badge(
//                               showBadge:
//                                   dailyActivityController.messageCount != 0
//                                       ? true
//                                       : false,
//                               badgeContent: SizedBox(
//                                   width: 20, //height: 20, //badge size
//                                   child: Center(
//                                     //aligh badge content to center
//                                     child: Text(
//                                         "${dailyActivityController.messageCount}",
//                                         style: TextStyle(
//                                             color:
//                                                 Colors.white, //badge font color
//                                             fontSize: 20 //badge font size
//                                             )),
//                                   )),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.messages,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Messages",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                             )),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   dailyActivityController.stuUpdateCounter("assignment");
//                   dailyActivityController.assignmentCount(0);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const Assignments(
//                               name: "Assignments",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.blue, Color(0xFF90CAF9)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(() => dailyActivityController.isLoading.value
//                           ? ShimmerWidget.rectangular(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height,
//                             )
//                           : Badge(
//                               showBadge:
//                                   dailyActivityController.assignmentCount != 0
//                                       ? true
//                                       : false,
//                               badgeContent: SizedBox(
//                                   width: 20, //height: 20, //badge size
//                                   child: Align(
//                                     //
//                                     alignment: Alignment
//                                         .center, // aligh badge content to center
//                                     child: Text("3",
//                                         style: TextStyle(
//                                             color:
//                                                 Colors.white, //badge font color
//                                             fontSize: 20 //badge font size
//                                             )),
//                                   )),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.messageAssignment,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Assignments",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                             )),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const Attendance(
//                               name: "Attendance",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.deepPurple, Color(0xFFB39DDB)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                     AssetImages.drawerAttendence,
//                                     width: 45.0,
//                                     height: 45.0,
//                                   ),
//                                   Text(
//                                     "Attendance",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ViewEvents(
//                               name: "View Events",
//                             )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.pink, Color(0xFFF48FB1)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.assessmentCert,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "View Events",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   dailyActivityController.stuUpdateCounter("event");
//                   dailyActivityController.stuUpdateCounter("other");
//                   dailyActivityController.eventCount(0);
//                   dailyActivityController.otherCount(0);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Feeds()),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.orange, Color(0xFFFFCC80)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(() => dailyActivityController.isLoading.value
//                           ? ShimmerWidget.rectangular(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height,
//                             )
//                           : Badge(
//                               showBadge: (dailyActivityController.otherCount !=
//                                           0 ||
//                                       dailyActivityController.eventCount != 0)
//                                   ? true
//                                   : false,
//                               badgeContent: SizedBox(
//                                   width: 20, //height: 20, //badge size
//                                   child: Center(
//                                     //aligh badge content to center
//                                     child: Text(
//                                         "${dailyActivityController.otherCount.value + dailyActivityController.eventCount.value}",
//                                         style: TextStyle(
//                                             color:
//                                                 Colors.white, //badge font color
//                                             fontSize: 20 //badge font size
//                                             )),
//                                   )),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.newsFeeds,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Feeds",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                             )),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Documents()),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.green, Color(0xFFA5D6A7)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     AssetImages.documents,
//                                     width: 50.0,
//                                     height: 50.0,
//                                   ),
//                                   Text(
//                                     "Documents",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               ),
//               InkWell(
//                 splashColor: ColorConstants.kTransparentColor,
//                 highlightColor: ColorConstants.kTransparentColor,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Pickupcard()),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [Colors.red, Color(0xFFEF9A9A)]),
//                         borderRadius: containeBorderRadius,
//                       ),
//                       child: Obx(
//                         () => dailyActivityController.isLoading.value
//                             ? ShimmerWidget.rectangular(
//                                 width: MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height,
//                               )
//                             : Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(
//                                     AssetImages.drawerPickUpCard,
//                                     width: 45.0,
//                                     height: 45.0,
//                                   ),
//                                   Text(
//                                     "Pickup Card",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.center,
//                                     style: buttonTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )),
//               )
//             ],
//           ),
//         );
//
//     _activityCard() {
//       return Obx(() => Container(
//           child: dailyActivityController.isLoading.value
//               ? Container(
//                   height: 250.0,
//                   color: ColorConstants.kGreyColor100,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 18.0,
//                       bottom: 18,
//                       left: 30,
//                     ),
//                     child: buildActivityShimmer(),
//                   ))
//               : Container(
//                   height: dailyActivityController.status ==
//                           "No activities found for today"
//                       ? 130
//                       : 292.0,
//                   color: ColorConstants.kGreyColor100,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 18.0,
//                       bottom: 18,
//                       left: 30,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   WidgetSpan(
//                                     child: Transform.translate(
//                                       offset: const Offset(0.0, 3.0),
//                                       child: Image.asset(
//                                         AssetImages.activities,
//                                         height: 30.0,
//                                         width: 30.0,
//                                       ),
//                                     ),
//                                   ),
//                                   const WidgetSpan(
//                                     child: SizedBox(
//                                       width: 5.0,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: Constants.translate(context)
//                                         .txt_activities
//                                         .toUpperCase(),
//                                     style: greetingTextStyle,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         smallSizedBox,
//                         Align(
//                             alignment: Alignment.topLeft,
//                             child:
//                                 dailyActivityController.status ==
//                                         "No activities found for today"
//                                     ? Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           mediumSizedBox,
//                                           Text("No activities found for today")
//                                         ],
//                                       )
//                                     : DefaultTabController(
//                                         length: 2,
//                                         child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(right: 5),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 TabBar(
//                                                   // ignore: prefer_const_literals_to_create_immutables
//                                                   tabs: [
//                                                     Tab(
//                                                       text: "Sports",
//                                                     ),
//                                                     Tab(
//                                                       text: "Others",
//                                                     )
//                                                   ],
//                                                   isScrollable: true,
//                                                   indicator: BoxDecoration(
//                                                     color: Color.fromARGB(
//                                                         255, 238, 220, 241),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             25),
//                                                   ),
//                                                   indicatorPadding:
//                                                       EdgeInsets.only(
//                                                           top: 8,
//                                                           bottom: 10,
//                                                           left: 4,
//                                                           right: 4),
//                                                   labelColor: ColorConstants
//                                                       .kHeadingTextColor,
//                                                   labelStyle:
//                                                       TextStyle(fontSize: 15),
//                                                   unselectedLabelColor:
//                                                       ColorConstants
//                                                           .kBlackColor,
//                                                 ),
//                                                 SizedBox(
//                                                     height: 157.0,
//                                                     //width: 120,
//                                                     child: TabBarView(
//                                                         children: [
//                                                           dailyActivityController
//                                                                       .sport_activities
//                                                                       .length ==
//                                                                   0
//                                                               ? Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     mediumSizedBox,
//                                                                     Text(
//                                                                         "No sports activities found for today")
//                                                                   ],
//                                                                 )
//                                                               : ListView
//                                                                   .builder(
//                                                                   scrollDirection:
//                                                                       Axis.horizontal,
//                                                                   shrinkWrap:
//                                                                       true,
//                                                                   itemCount:
//                                                                       dailyActivityController
//                                                                           .sport_activities
//                                                                           .length,
//                                                                   itemBuilder:
//                                                                       (context,
//                                                                               index) =>
//                                                                           InkWell(
//                                                                     onTap: () {
//                                                                       Navigator
//                                                                           .push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) =>
//                                                                                 Activity(
//                                                                                   title: "activities",
//                                                                                   id: '1',
//                                                                                   name: "Activity",
//                                                                                 )),
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           Container(
//                                                                             width:
//                                                                                 110.0,
//                                                                             height:
//                                                                                 110.0,
//                                                                             decoration:
//                                                                                 BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
//                                                                             child:
//                                                                                 Center(
//                                                                               child: Image.network(
//                                                                                 dailyActivityController.sport_activities[index].activityImage,
//                                                                                 width: 80.0,
//                                                                                 height: 80.0,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           smallSizedBox,
//                                                                           Text(
//                                                                             dailyActivityController.sport_activities[index].activityTitle,
//                                                                             textAlign:
//                                                                                 TextAlign.center,
//                                                                             style:
//                                                                                 greetingTextStyle,
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                           dailyActivityController
//                                                                       .other_activities
//                                                                       .length ==
//                                                                   0
//                                                               ? Column(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .start,
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     mediumSizedBox,
//                                                                     Text(
//                                                                         "No other activities found for today")
//                                                                   ],
//                                                                 )
//                                                               : ListView
//                                                                   .builder(
//                                                                   scrollDirection:
//                                                                       Axis.horizontal,
//                                                                   shrinkWrap:
//                                                                       true,
//                                                                   itemCount:
//                                                                       dailyActivityController
//                                                                           .other_activities
//                                                                           .length,
//                                                                   itemBuilder:
//                                                                       (context,
//                                                                               index) =>
//                                                                           InkWell(
//                                                                     onTap: () {
//                                                                       Navigator
//                                                                           .push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) =>
//                                                                                 Activity(
//                                                                                   title: "activities",
//                                                                                   id: '2',
//                                                                                   name: "Activity",
//                                                                                 )),
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           Container(
//                                                                             width:
//                                                                                 110.0,
//                                                                             height:
//                                                                                 110.0,
//                                                                             decoration:
//                                                                                 BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
//                                                                             child:
//                                                                                 Center(
//                                                                               child: Image.network(
//                                                                                 dailyActivityController.other_activities[index].activityImage,
//                                                                                 width: 80.0,
//                                                                                 height: 80.0,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           smallSizedBox,
//                                                                           Text(
//                                                                             dailyActivityController.other_activities[index].activityTitle,
//                                                                             textAlign:
//                                                                                 TextAlign.center,
//                                                                             style:
//                                                                                 greetingTextStyle,
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                         ]))
//                                               ],
//                                             )),
//                                       )),
//                         /*Expanded(
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     itemCount: _activityData().length,
//                     itemBuilder: (context, index) =>
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                   _activityData()[index]['page']),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 110.0,
//                                   height: 110.0,
//                                   decoration: BoxDecoration(
//                                       color: ColorConstants.kWhiteColor,
//                                       borderRadius: BorderRadius.circular(
//                                           10.0)),
//                                   child: Center(
//                                     child: Image.asset(
//                                       _activityData()[index]['icon'],
//                                       width: 80.0,
//                                       height: 80.0,
//                                     ),
//                                   ),
//                                 ),
//                                 smallSizedBox,
//                                 Text(
//                                   _activityData()[index]['title'],
//                                   textAlign: TextAlign.center,
//                                   style: greetingTextStyle,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                   ),
//                 ),*/
//                       ],
//                     ),
//                   ),
//                 )));
//     }
//
//     welcomeText() => Text(
//           Strings.welcome,
//           style: subtitleTextStyle,
//         );
//
//     nameText() =>
//         Obx(() => Text(loginController.studentName.value.toUpperCase(),
//             style: titleTextStyle));
//
//     dateText() => Text(
//           DateFormat('dd MMMM yyyy').format(DateTime.now()),
//           style: textButtonTextStyle,
//         );
//
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: showBar
//           ? CustomAppBar(
//               scaffoldKey: _scaffoldKey,
//               automaticallyImplyLeading: true,
//             )
//           : null,
//       extendBodyBehindAppBar: true,
//       drawer: const CustomDrawer(),
//       drawerEdgeDragWidth: 0.0,
//       // extendBody: true,
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: Image.asset(
//               AssetImages.mainBackground,
//               //width: double.infinity,
//               height: MediaQuery.of(context).size.height / 4,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: ListView(
//               controller: scrollController,
//               shrinkWrap: true,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           welcomeText(),
//                         ],
//                       ),
//                       smallerSizedBox,
//                       nameText(),
//                       smallSizedBox,
//                       dateText(),
//                       smallSizedBox,
//                       divider,
//                       largeSizedBox,
//                       gridView(),
//                       largeSizedBox,
//                       _activityCard(),
//                       largeSizedBox,
//                       largeSizedBox,
//                       largeSizedBox,
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildActivityShimmer() {
//     return Container(
//         child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ShimmerWidget.rectangular(
//               height: 30,
//               width: 130,
//             ),
//           ],
//         ),
//         smallSizedBox,
//         Expanded(
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             itemCount: 3,
//             itemBuilder: (context, index) => InkWell(
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 110.0,
//                       height: 110.0,
//                       decoration: BoxDecoration(
//                           color: ColorConstants.kWhiteColor,
//                           borderRadius: BorderRadius.circular(10.0)),
//                       child: Center(
//                           child: ShimmerWidget.rectangular(
//                               width: 110, height: 110)),
//                     ),
//                     smallSizedBox,
//                     ShimmerWidget.rectangular(width: 60, height: 20)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/activities.dart';
import 'package:little_angels/Student/assignments.dart';
import 'package:little_angels/Student/attendance.dart';
import 'package:little_angels/Student/activity_details.dart';
import 'package:little_angels/Student/document.dart';
import 'package:little_angels/Student/feeds.dart';
import 'package:little_angels/Student/message.dart';
import 'package:little_angels/Student/my_profile.dart';
import 'package:little_angels/Student/notification.dart';
import 'package:little_angels/Student/pickupcard.dart';
import 'package:little_angels/Student/subjects.dart';
import 'package:little_angels/Student/video.dart';
import 'package:little_angels/Student/view_events.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/todays_work.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_drawer.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/shimmerWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../Controller/dailyActivityController.dart';
import '../Controller/loginController.dart';
import '../utils/network_handler.dart';

class StudentHome extends StatefulWidget {
  final String? id;
  final String? name;

  const StudentHome({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  DateTime todayDate = DateTime.now();

  CarouselController carouselController = CarouselController();

  //final DateFormat formatter = DateFormat('EEEE');
  // final DateFormat formatter1 = DateFormat('dMMMM');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var loginController = Get.put(LoginController());
  var dailyActivityController = Get.put(DailyActivityController());

  //for animation
  int currentIndex = 0;
  AlignmentDirectional topCenterAlign = AlignmentDirectional.topCenter;
  AlignmentDirectional topLeftAlign = AlignmentDirectional.centerStart;
  AlignmentDirectional bottomCenterAlign = AlignmentDirectional.bottomCenter;
  AlignmentDirectional topRightAlign = AlignmentDirectional.centerEnd;

  List<GredientColorForAnimation> gredientColor = [
    GredientColorForAnimation(
        colo1: Color(0xffa277f4),
        colo2: Color(0xff7d5efa),
        shadow: Color(0xffD0AFFD)),
    GredientColorForAnimation(
      colo1: Color(0xffee8f62),
      colo2: Color(0xfff9a45b),
      shadow: Color(0xfffde4ce),
    ),
    GredientColorForAnimation(
      colo1: Color(0xffa268AAF),
      colo2: Color(0xff22B9D3),
      shadow: Color(0xff81B5BD),
    ),
    GredientColorForAnimation(
      colo1: Color(0xffEE8E6D),
      colo2: Color(0xffF97F7F),
      shadow: Color(0xffFED6C2),
    ),
  ];

  List<SliderAniData>? sliderAniData = [
    SliderAniData(text: Strings.todayWork, listOfImage: [
      ImageData(
          imageString: AssetImages.calendarAniCard,
          imageName: Strings.calender),
      ImageData(
          imageString: AssetImages.assignmentAniCard,
          imageName: Strings.assignment),
      ImageData(
          imageString: AssetImages.todayWork, imageName: Strings.todayWork),
      ImageData(
          imageString: AssetImages.subjectAniCard, imageName: Strings.subjects),
    ]),
    SliderAniData(text: Strings.assignment, listOfImage: [
      ImageData(
          imageString: AssetImages.calendarAniCard,
          imageName: Strings.calender),
      ImageData(
          imageString: AssetImages.assignmentAniCard,
          imageName: Strings.assignment),
      ImageData(
          imageString: AssetImages.todayWork, imageName: Strings.todayWork),
      ImageData(
          imageString: AssetImages.subjectAniCard, imageName: Strings.subjects),
    ]),
    SliderAniData(text: Strings.subjects, listOfImage: [
      ImageData(
          imageString: AssetImages.calendarAniCard,
          imageName: Strings.calender),
      ImageData(
          imageString: AssetImages.assignmentAniCard,
          imageName: Strings.assignment),
      ImageData(
          imageString: AssetImages.todayWork, imageName: Strings.todayWork),
      ImageData(
          imageString: AssetImages.subjectAniCard, imageName: Strings.subjects),
    ]),
    SliderAniData(text: Strings.calender, listOfImage: [
      ImageData(
          imageString: AssetImages.calendarAniCard,
          imageName: Strings.calender),
      ImageData(
          imageString: AssetImages.assignmentAniCard,
          imageName: Strings.assignment),
      ImageData(
          imageString: AssetImages.todayWork, imageName: Strings.todayWork),
      ImageData(
          imageString: AssetImages.subjectAniCard, imageName: Strings.subjects),
    ]),
  ];

  final List<Map<String, dynamic>> _data = [
    {
      'title': "Today's Work",
      'icon': AssetImages.todayWork,
      'color': const LinearGradient(colors: [Colors.orange, Color(0xFFFFCC80)]),
      'page': const TodaysWork(
        name: "Today's Work",
      )
    },
    {
      'title': "Video",
      'icon': AssetImages.video,
      'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
      'page': const Video(
        name: "Video",
      )
    },
    {
      'title': "Messages",
      'icon': AssetImages.messages,
      'color': const LinearGradient(colors: [Colors.red, Color(0xFFEF9A9A)]),
      'page': const Message(
        name: "Message",
      )
    },
    {
      'title': "Assignments",
      'icon': AssetImages.messageAssignment,
      'color': const LinearGradient(colors: [Colors.blue, Color(0xFF90CAF9)]),
      'page': const Assignments(
        name: "Assignments",
      )
    },
    {
      'title': "Attendance",
      'icon': AssetImages.drawerAttendence,
      'color':
          const LinearGradient(colors: [Colors.deepPurple, Color(0xFFB39DDB)]),
      'page': const Attendance(
        name: "Attendance",
      )
    },
    {
      'title': "View Events",
      'icon': AssetImages.assessmentCert,
      'color': const LinearGradient(colors: [Colors.pink, Color(0xFFF48FB1)]),
      'page': const ViewEvents(
        name: "View Events",
      )
    },
    {
      'title': "Feeds",
      'icon': AssetImages.newsFeeds,
      'color': const LinearGradient(colors: [Colors.orange, Color(0xFFFFCC80)]),
      'page': const Feeds()
    },
    {
      'title': "Documents",
      'icon': AssetImages.documents,
      'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
      'page': const Documents()
    },
    {
      'title': "Pickup Card",
      'icon': AssetImages.drawerPickUpCard,
      'color': const LinearGradient(colors: [Colors.red, Color(0xFFEF9A9A)]),
      'page': const Pickupcard()
    },
  ];

  final ScrollController scrollController = ScrollController();
  bool showBar = true;
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 2, vsync: this);
    _init();
    super.initState();
    checkScroll();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dailyActivityController.getStuActivity();
      });
    } else {
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

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(() {});
    super.dispose();
  }

  checkScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent > 120.0 &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        setState(() {
          showBar = false;
        });
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showBar = true;
        });
      }
    });
  }

  sliderWidget({
    String? text,
    required int index,
  }) {
    return Container(
      alignment: Alignment.center,
      // height: 200.0,
      // width: 390.0,
      margin: EdgeInsets.symmetric(horizontal: 19.0),
      decoration: BoxDecoration(
          borderRadius: containeBorderRadius,
          gradient: LinearGradient(colors: [
            gredientColor[currentIndex].colo1,
            gredientColor[currentIndex].colo2,
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetImages.userCard,
            height: 80.0,
          ),
          smallSizedBox,
          Text('${text}', style: titleTextStyle.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // MediaQuery gridView() => MediaQuery.removePadding(
    //       removeTop: true,
    //       context: context,
    //       child: GridView(
    //         shrinkWrap: true,
    //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 3,
    //           mainAxisSpacing: 15,
    //           crossAxisSpacing: 10,
    //           childAspectRatio: 1,
    //         ),
    //         children: [
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const TodaysWork(
    //                           name: "Today's Work",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.orange, Color(0xFFFFCC80)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.todaysWork,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Today's Work",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const Video(
    //                           name: "Video",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.green, Color(0xFFA5D6A7)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.video,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Video",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               dailyActivityController.stuUpdateCounter("message");
    //               dailyActivityController.messageCount(0);
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const Message(
    //                           name: "Message",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.red, Color(0xFFEF9A9A)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(() => dailyActivityController.isLoading.value
    //                       ? ShimmerWidget.rectangular(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: MediaQuery.of(context).size.height,
    //                         )
    //                       : Badge(
    //                           showBadge:
    //                               dailyActivityController.messageCount != 0
    //                                   ? true
    //                                   : false,
    //                           badgeContent: SizedBox(
    //                               width: 20, //height: 20, //badge size
    //                               child: Center(
    //                                 //aligh badge content to center
    //                                 child: Text(
    //                                     "${dailyActivityController.messageCount}",
    //                                     style: TextStyle(
    //                                         color:
    //                                             Colors.white, //badge font color
    //                                         fontSize: 20 //badge font size
    //                                         )),
    //                               )),
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.messages,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Messages",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                         )),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               dailyActivityController.stuUpdateCounter("assignment");
    //               dailyActivityController.assignmentCount(0);
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const Assignments(
    //                           name: "Assignments",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.blue, Color(0xFF90CAF9)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(() => dailyActivityController.isLoading.value
    //                       ? ShimmerWidget.rectangular(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: MediaQuery.of(context).size.height,
    //                         )
    //                       : Badge(
    //                           showBadge:
    //                               dailyActivityController.assignmentCount != 0
    //                                   ? true
    //                                   : false,
    //                           badgeContent: SizedBox(
    //                               width: 20, //height: 20, //badge size
    //                               child: Align(
    //                                 //
    //                                 alignment: Alignment
    //                                     .center, // aligh badge content to center
    //                                 child: Text("3",
    //                                     style: TextStyle(
    //                                         color:
    //                                             Colors.white, //badge font color
    //                                         fontSize: 20 //badge font size
    //                                         )),
    //                               )),
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.messageAssignment,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Assignments",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                         )),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const Attendance(
    //                           name: "Attendance",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.deepPurple, Color(0xFFB39DDB)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               SvgPicture.asset(
    //                                 AssetImages.drawerAttendence,
    //                                 width: 45.0,
    //                                 height: 45.0,
    //                               ),
    //                               Text(
    //                                 "Attendance",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => const ViewEvents(
    //                           name: "View Events",
    //                         )),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.pink, Color(0xFFF48FB1)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.assessmentCert,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "View Events",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               dailyActivityController.stuUpdateCounter("event");
    //               dailyActivityController.stuUpdateCounter("other");
    //               dailyActivityController.eventCount(0);
    //               dailyActivityController.otherCount(0);
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => const Feeds()),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.orange, Color(0xFFFFCC80)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(() => dailyActivityController.isLoading.value
    //                       ? ShimmerWidget.rectangular(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: MediaQuery.of(context).size.height,
    //                         )
    //                       : Badge(
    //                           showBadge: (dailyActivityController.otherCount !=
    //                                       0 ||
    //                                   dailyActivityController.eventCount != 0)
    //                               ? true
    //                               : false,
    //                           badgeContent: SizedBox(
    //                               width: 20, //height: 20, //badge size
    //                               child: Center(
    //                                 //aligh badge content to center
    //                                 child: Text(
    //                                     "${dailyActivityController.otherCount.value + dailyActivityController.eventCount.value}",
    //                                     style: TextStyle(
    //                                         color:
    //                                             Colors.white, //badge font color
    //                                         fontSize: 20 //badge font size
    //                                         )),
    //                               )),
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.newsFeeds,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Feeds",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                         )),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => const Documents()),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.green, Color(0xFFA5D6A7)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Image.asset(
    //                                 AssetImages.documents,
    //                                 width: 50.0,
    //                                 height: 50.0,
    //                               ),
    //                               Text(
    //                                 "Documents",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           ),
    //           InkWell(
    //             splashColor: ColorConstants.kTransparentColor,
    //             highlightColor: ColorConstants.kTransparentColor,
    //             onTap: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => const Pickupcard()),
    //               );
    //             },
    //             child: Padding(
    //                 padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     gradient: const LinearGradient(
    //                         colors: [Colors.red, Color(0xFFEF9A9A)]),
    //                     borderRadius: containeBorderRadius,
    //                   ),
    //                   child: Obx(
    //                     () => dailyActivityController.isLoading.value
    //                         ? ShimmerWidget.rectangular(
    //                             width: MediaQuery.of(context).size.width,
    //                             height: MediaQuery.of(context).size.height,
    //                           )
    //                         : Column(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               SvgPicture.asset(
    //                                 AssetImages.drawerPickUpCard,
    //                                 width: 45.0,
    //                                 height: 45.0,
    //                               ),
    //                               Text(
    //                                 "Pickup Card",
    //                                 maxLines: 1,
    //                                 textAlign: TextAlign.center,
    //                                 style: buttonTextStyle,
    //                               ),
    //                             ],
    //                           ),
    //                   ),
    //                 )),
    //           )
    //         ],
    //       ),
    //     );

    _activityCard() {
      return Obx(() => Container(
          child: dailyActivityController.isLoading.value
              ? Container(
                  height: 250.0,
                  color: ColorConstants.kGreyColor100,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 18,
                      left: 30,
                    ),
                    child: buildActivityShimmer(),
                  ))
              : Container(
                  height: dailyActivityController.status ==
                          "No activities found for today"
                      ? 130
                      : 292.0,
                  color: ColorConstants.kGreyColor100,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 18,
                      left: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(0.0, 3.0),
                                      child: Image.asset(
                                        AssetImages.activities,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width: 5.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: Constants.translate(context)
                                        .txt_activities
                                        .toUpperCase(),
                                    style: greetingTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        smallSizedBox,
                        Align(
                            alignment: Alignment.topLeft,
                            child:
                                dailyActivityController.status ==
                                        "No activities found for today"
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          mediumSizedBox,
                                          Text("No activities found for today")
                                        ],
                                      )
                                    : DefaultTabController(
                                        length: 2,
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TabBar(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  tabs: [
                                                    Tab(
                                                      text: "Sports",
                                                    ),
                                                    Tab(
                                                      text: "Others",
                                                    )
                                                  ],
                                                  isScrollable: true,
                                                  indicator: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 238, 220, 241),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  indicatorPadding:
                                                      EdgeInsets.only(
                                                          top: 8,
                                                          bottom: 10,
                                                          left: 4,
                                                          right: 4),
                                                  labelColor: ColorConstants
                                                      .kHeadingTextColor,
                                                  labelStyle:
                                                      TextStyle(fontSize: 15),
                                                  unselectedLabelColor:
                                                      ColorConstants
                                                          .kBlackColor,
                                                ),
                                                SizedBox(
                                                    height: 157.0,
                                                    //width: 120,
                                                    child: TabBarView(
                                                        children: [
                                                          dailyActivityController
                                                                      .sport_activities
                                                                      .length ==
                                                                  0
                                                              ? Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    mediumSizedBox,
                                                                    Text(
                                                                        "No sports activities found for today")
                                                                  ],
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      dailyActivityController
                                                                          .sport_activities
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          InkWell(
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Activity(
                                                                                  title: "activities",
                                                                                  id: '1',
                                                                                  name: "Activity",
                                                                                )),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                110.0,
                                                                            height:
                                                                                110.0,
                                                                            decoration:
                                                                                BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                dailyActivityController.sport_activities[index].activityImage,
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          smallSizedBox,
                                                                          Text(
                                                                            dailyActivityController.sport_activities[index].activityTitle,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                greetingTextStyle,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          dailyActivityController
                                                                      .other_activities
                                                                      .length ==
                                                                  0
                                                              ? Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    mediumSizedBox,
                                                                    Text(
                                                                        "No other activities found for today")
                                                                  ],
                                                                )
                                                              : ListView
                                                                  .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      dailyActivityController
                                                                          .other_activities
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          InkWell(
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Activity(
                                                                                  title: "activities",
                                                                                  id: '2',
                                                                                  name: "Activity",
                                                                                )),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                110.0,
                                                                            height:
                                                                                110.0,
                                                                            decoration:
                                                                                BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
                                                                            child:
                                                                                Center(
                                                                              child: Image.network(
                                                                                dailyActivityController.other_activities[index].activityImage,
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          smallSizedBox,
                                                                          Text(
                                                                            dailyActivityController.other_activities[index].activityTitle,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                greetingTextStyle,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ]))
                                              ],
                                            )),
                                      )),
                        /*Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _activityData().length,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  _activityData()[index]['page']),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 110.0,
                                  height: 110.0,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.kWhiteColor,
                                      borderRadius: BorderRadius.circular(
                                          10.0)),
                                  child: Center(
                                    child: Image.asset(
                                      _activityData()[index]['icon'],
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                  ),
                                ),
                                smallSizedBox,
                                Text(
                                  _activityData()[index]['title'],
                                  textAlign: TextAlign.center,
                                  style: greetingTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                  ),
                ),*/
                      ],
                    ),
                  ),
                )));
    }

    welcomeText() => Text(
          Strings.welcome,
          style: subtitleTextStyle,
        );

    nameText() =>
        Obx(() => Text(loginController.studentName.value.toUpperCase(),
            style: titleTextStyle));

    dateText() => Text(
          DateFormat('dd MMMM yyyy').format(DateTime.now()),
          style: textButtonTextStyle,
        );

    return Scaffold(
      key: _scaffoldKey,
      appBar: showBar
          ? CustomAppBar(
              scaffoldKey: _scaffoldKey,
              automaticallyImplyLeading: true,
            )
          : null,
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
      drawerEdgeDragWidth: 0.0,
      // extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffFFFFF),
            Color(0xffFFF5FA),
          ])),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  AssetImages.mainBackground,
                  //width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        welcomeText(),
                      ],
                    ),
                    smallerSizedBox,
                    nameText(),
                    smallSizedBox,
                    dateText(),
                    smallSizedBox,
                    //divider,
                    largeSizedBox,
                    smallSizedBox,
                    sliderAnimation(),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActivityShimmer() {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerWidget.rectangular(
              height: 30,
              width: 130,
            ),
          ],
        ),
        smallSizedBox,
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                          color: ColorConstants.kWhiteColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                          child: ShimmerWidget.rectangular(
                              width: 110, height: 110)),
                    ),
                    smallSizedBox,
                    ShimmerWidget.rectangular(width: 60, height: 20)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  sliderAnimation() {
    return Expanded(
        child: Column(children: [
      Expanded(
        flex: 6,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: topLeftAlign,
              curve: Curves.linearToEaseOut,
              child: imageAndString(
                  index: 0,
                  topPadding:
                      (topLeftAlign == AlignmentDirectional.centerStart ||
                              topLeftAlign == AlignmentDirectional.centerEnd)
                          ? 35.0
                          : 0.0,
                  bottomPadding:
                      topLeftAlign == AlignmentDirectional.bottomCenter
                          ? 20.0
                          : 0.0),
              duration: Duration(milliseconds: 600),
            ),
            AnimatedAlign(
              alignment: topRightAlign,
              curve: Curves.linearToEaseOut,
              child: imageAndString(
                  index: 1,
                  topPadding:
                      (topRightAlign == AlignmentDirectional.centerStart ||
                              topRightAlign == AlignmentDirectional.centerEnd)
                          ? 35.0
                          : 0.0,
                  bottomPadding:
                      topRightAlign == AlignmentDirectional.bottomCenter
                          ? 20.0
                          : 0.0),
              duration: Duration(milliseconds: 600),
            ),
            AnimatedAlign(
              alignment: bottomCenterAlign,
              curve: Curves.linearToEaseOut,
              child: imageAndString(
                  index: 2,
                  topPadding: (bottomCenterAlign ==
                              AlignmentDirectional.centerStart ||
                          bottomCenterAlign == AlignmentDirectional.centerEnd)
                      ? 35.0
                      : 0.0,
                  bottomPadding:
                      bottomCenterAlign == AlignmentDirectional.bottomCenter
                          ? 20.0
                          : 0.0),
              duration: Duration(milliseconds: 600),
            ),
            AnimatedAlign(
              alignment: topCenterAlign,
              curve: Curves.linearToEaseOut,
              child: imageAndString(
                  index: 3,
                  topPadding:
                      (topCenterAlign == AlignmentDirectional.centerStart ||
                              topCenterAlign == AlignmentDirectional.centerEnd)
                          ? 35.0
                          : 0.0,
                  bottomPadding:
                      topCenterAlign == AlignmentDirectional.bottomCenter
                          ? 20.0
                          : 0.0),
              duration: Duration(milliseconds: 800),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: gredientColor[currentIndex].shadow,
                      blurRadius: 40.0,
                      spreadRadius: 2,
                      offset: Offset(0.0, 4.0))
                ],
              ),

              //decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('curre $currentIndex');
                      if (currentIndex == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => TodaysWork())));
                      } else if (currentIndex == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Assignments())));
                      } else if (currentIndex == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Subjects())));
                      } else {}
                    },
                    child: Container(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: sliderAniData?.length,
                        itemBuilder: (context, index, index2) {
                          return sliderWidget(
                              text: sliderAniData?[index].text, index: index);
                        },
                        options: CarouselOptions(
                          initialPage: 0,
                          pageSnapping: true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          // autoPlay: true,
                          //autoPlayCurve: Curves.bounceOut,

                          onPageChanged: (data, val) {
                            setState(() {
                              currentIndex = data;
                            });
                            updateAnimation(cur: currentIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        sliderAniData!.length,
                        (index) => buildDot(index, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Expanded(
      //     flex: 4,
      //     child: Container(
      //       //  color: Colors.red,
      //       width: double.infinity,
      //       padding: EdgeInsets.symmetric(horizontal: 8.0),
      //       child: Stack(
      //         children: [
      //           AnimatedPositioned(
      //             top: 0.0,
      //             duration: Duration(seconds: 1),
      //             child: Container(
      //               color: Colors.black12,
      //               height: 120.0,
      //               width: 120.0,
      //               child: AnimatedAlign(
      //                 alignment: Alignment.topLeft,
      //                 duration: Duration(seconds: 1),
      //                 child: Image.asset(
      //                   AssetImages.assignmentAniCard,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           AnimatedPositioned(
      //             top: 0.0,
      //             right: 0.0,
      //             duration: Duration(seconds: 1),
      //             child: Container(
      //               color: Colors.green,
      //               height: 120.0,
      //               width: 120.0,
      //               child: AnimatedAlign(
      //                 alignment: Alignment.topRight,
      //                 duration: Duration(seconds: 1),
      //                 child: Image.asset(
      //                   AssetImages.calendarAniCard,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           AnimatedPositioned(
      //             bottom: 0.0,
      //             left: MediaQuery.of(context).size.width / 3,
      //             duration: Duration(seconds: 1),
      //             child: Container(
      //               color: Colors.lightBlue,
      //               height: 120.0,
      //               width: 120.0,
      //               child: AnimatedAlign(
      //                 alignment: Alignment.bottomCenter,
      //                 duration: Duration(seconds: 1),
      //                 child: Image.asset(
      //                   AssetImages.subjectAniCard,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     )),
      Expanded(
          flex: 1,
          child: Container(
              //color: Colors.grey,
              ))
    ]));
  }

  imageAndString(
      {required int index,
      required double topPadding,
      required double bottomPadding}) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: GestureDetector(
        onTap: () {
          if (sliderAniData?[currentIndex].text ==
              sliderAniData![currentIndex]
                  .listOfImage![index]
                  .imageName
                  .toString()) {
            if (currentIndex == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => TodaysWork())));
            } else if (currentIndex == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Assignments())));
            } else if (currentIndex == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Subjects())));
            } else {}
          } else {
            print('Current $currentIndex');
            print(
                'Current ${sliderAniData![currentIndex].listOfImage![index].imageName.toString()}');
            if (sliderAniData?[currentIndex].text == Strings.todayWork) {
              if (sliderAniData![currentIndex]
                      .listOfImage![index]
                      .imageName
                      .toString() ==
                  Strings.assignment) {
                carouselController.animateToPage(currentIndex + 1,
                    curve: Curves.ease, duration: Duration(milliseconds: 800));
              } else {
                carouselController.animateToPage(
                    currentIndex == 0
                        ? 3
                        : (currentIndex == 3 &&
                                sliderAniData![currentIndex]
                                        .listOfImage![index]
                                        .imageName
                                        .toString() ==
                                    Strings.todayWork)
                            ? currentIndex + 1
                            : currentIndex - 1,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 800));
              }
            }
            if (sliderAniData?[currentIndex].text == Strings.assignment) {
              if (sliderAniData![currentIndex]
                      .listOfImage![index]
                      .imageName
                      .toString() ==
                  Strings.subjects) {
                carouselController.animateToPage(currentIndex + 1,
                    curve: Curves.ease, duration: Duration(milliseconds: 800));
              } else {
                carouselController.animateToPage(
                    currentIndex == 0
                        ? 3
                        : (currentIndex == 3 &&
                                sliderAniData![currentIndex]
                                        .listOfImage![index]
                                        .imageName
                                        .toString() ==
                                    Strings.todayWork)
                            ? currentIndex + 1
                            : currentIndex - 1,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 800));
              }
            }
            if (sliderAniData?[currentIndex].text == Strings.subjects) {
              if (sliderAniData![currentIndex]
                      .listOfImage![index]
                      .imageName
                      .toString() ==
                  Strings.calender) {
                carouselController.animateToPage(currentIndex + 1,
                    curve: Curves.ease, duration: Duration(milliseconds: 800));
              } else {
                carouselController.animateToPage(
                    currentIndex == 0
                        ? 3
                        : (currentIndex == 3 &&
                                sliderAniData![currentIndex]
                                        .listOfImage![index]
                                        .imageName
                                        .toString() ==
                                    Strings.todayWork)
                            ? currentIndex + 1
                            : currentIndex - 1,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 800));
              }
            }
            if (sliderAniData?[currentIndex].text == Strings.calender) {
              if (sliderAniData![currentIndex]
                      .listOfImage![index]
                      .imageName
                      .toString() ==
                  Strings.todayWork) {
                carouselController.animateToPage(currentIndex + 1,
                    curve: Curves.ease, duration: Duration(milliseconds: 800));
              } else {
                carouselController.animateToPage(
                    currentIndex == 0
                        ? 3
                        : (currentIndex == 3 &&
                                sliderAniData![currentIndex]
                                        .listOfImage![index]
                                        .imageName
                                        .toString() ==
                                    Strings.todayWork)
                            ? currentIndex + 1
                            : currentIndex - 1,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 800));
              }
            }
          }
        },
        child: Container(
            height: 170.0,
            width: 150.0,
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  sliderAniData![currentIndex]
                      .listOfImage![index]
                      .imageString
                      .toString(),
                  height: 148.0,
                  width: 148.0,
                  fit: BoxFit.fill,
                ),
                Text(
                    sliderAniData![currentIndex]
                        .listOfImage![index]
                        .imageName
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    style: buttonTextStyle.copyWith(
                      color: Colors.black,
                    )),
              ],
            )),
      ),
    );
  }

  updateAnimation({int? cur, String? text}) {
    setState(() {
      if (cur == 1) {
        topRightAlign = AlignmentDirectional.bottomCenter;
        topLeftAlign = AlignmentDirectional.topCenter;
        bottomCenterAlign = AlignmentDirectional.centerStart;
        topCenterAlign = AlignmentDirectional.centerEnd;
      } else if (cur == 2) {
        topLeftAlign = AlignmentDirectional.centerEnd;
        topRightAlign = AlignmentDirectional.centerStart;
        bottomCenterAlign = AlignmentDirectional.topCenter;
        topCenterAlign = AlignmentDirectional.bottomCenter;
      } else if (cur == 3) {
        topLeftAlign = AlignmentDirectional.bottomCenter;
        topRightAlign = AlignmentDirectional.topCenter;
        bottomCenterAlign = AlignmentDirectional.centerEnd;
        topCenterAlign = AlignmentDirectional.centerStart;
      } else {
        topLeftAlign = AlignmentDirectional.centerStart;
        topRightAlign = AlignmentDirectional.centerEnd;
        bottomCenterAlign = AlignmentDirectional.bottomCenter;
        topCenterAlign = AlignmentDirectional.topCenter;
      }

      // if (currentIndex == 1) {
      //   // Map<String, dynamic> topCenterList = {
      //   //   'top': 0.0,
      //   //   'bottom': 360.0,
      //   //   'left': 140.0,
      //   //   'right': 140.0,
      //   // };
      //   // Map<String, dynamic> topLeftList = {
      //   //   'top': 200.0,
      //   //   'left': 0.0,
      //   //   'bottom': 150.0,
      //   //   'right': 290.0,
      //   // };
      //   // Map<String, dynamic> bottomCenterList = {
      //   //   'top': 360.0,
      //   //   'bottom': 0.0,
      //   //   'left': 140.0,
      //   //   'right': 140.0,
      //   // };
      //   // Map<String, dynamic> topRightList = {
      //   //   'top': 200.0,
      //   //   'right': 0.0,
      //   //   'bottom': 150.0,
      //   //   'left': 290.0,
      //   // };
      //
      //   topRightAlign = Alignment.bottomCenter;
      //   topLeftAlign = Alignment.topCenter;
      //   bottomCenterAlign = Alignment.topRight;
      //   topCenterAlign = Alignment.topLeft;
      //
      //   topLeftList['top'] = topCenterTBLR[0];
      //   topLeftList['bottom'] = topCenterTBLR[1];
      //   topLeftList['left'] = topCenterTBLR[2];
      //   topLeftList['right'] = topCenterTBLR[3];
      //
      //   topRightList['top'] = bottomCenterTBLR[0];
      //   topRightList['bottom'] = bottomCenterTBLR[1];
      //   topRightList['left'] = bottomCenterTBLR[2];
      //   topRightList['right'] = bottomCenterTBLR[3];
      //
      //   bottomCenterList['top'] = topLeftTBLR[0];
      //   bottomCenterList['bottom'] = topLeftTBLR[1];
      //   bottomCenterList['left'] = topLeftTBLR[2];
      //   bottomCenterList['right'] = topLeftTBLR[3];
      //
      //   topCenterList['top'] = topRightTBLR[0];
      //   topCenterList['bottom'] = topRightTBLR[1];
      //   topCenterList['left'] = topRightTBLR[2];
      //   topCenterList['right'] = topRightTBLR[3];
      // } else if (currentIndex == 2) {
      //   topLeftAlign = Alignment.topRight;
      //   topRightAlign = Alignment.topLeft;
      //   bottomCenterAlign = Alignment.topCenter;
      //   topCenterAlign = Alignment.bottomCenter;
      //
      //   topLeftList['top'] = topRightTBLR[0];
      //   topLeftList['bottom'] = topRightTBLR[1];
      //   topLeftList['left'] = topRightTBLR[2];
      //   topLeftList['right'] = topRightTBLR[3];
      //
      //   topRightList['top'] = topLeftTBLR[0];
      //   topRightList['bottom'] = topLeftTBLR[1];
      //   topRightList['left'] = topLeftTBLR[2];
      //   topRightList['right'] = topLeftTBLR[3];
      //
      //   bottomCenterList['top'] = topCenterTBLR[0];
      //   bottomCenterList['bottom'] = topCenterTBLR[1];
      //   bottomCenterList['left'] = topCenterTBLR[2];
      //   bottomCenterList['right'] = topCenterTBLR[3];
      //
      //   topCenterList['top'] = bottomCenterTBLR[0];
      //   topCenterList['bottom'] = bottomCenterTBLR[1];
      //   topCenterList['left'] = bottomCenterTBLR[2];
      //   topCenterList['right'] = bottomCenterTBLR[3];
      // } else if (currentIndex == 3) {
      //   topLeftAlign = Alignment.bottomCenter;
      //   topRightAlign = Alignment.topCenter;
      //   bottomCenterAlign = Alignment.topRight;
      //   topCenterAlign = Alignment.topLeft;
      //
      //   topLeftList['top'] = bottomCenterTBLR[0];
      //   topLeftList['bottom'] = bottomCenterTBLR[1];
      //   topLeftList['left'] = bottomCenterTBLR[2];
      //   topLeftList['right'] = bottomCenterTBLR[3];
      //
      //   topRightList['top'] = topCenterTBLR[0];
      //   topRightList['bottom'] = topCenterTBLR[1];
      //   topRightList['left'] = topCenterTBLR[2];
      //   topRightList['right'] = topCenterTBLR[3];
      //
      //   bottomCenterList['top'] = topRightTBLR[0];
      //   bottomCenterList['bottom'] = topRightTBLR[1];
      //   bottomCenterList['left'] = topRightTBLR[2];
      //   bottomCenterList['right'] = topRightTBLR[3];
      //
      //   topCenterList['top'] = topLeftTBLR[0];
      //   topCenterList['bottom'] = topLeftTBLR[1];
      //   topCenterList['left'] = topLeftTBLR[2];
      //   topCenterList['right'] = topLeftTBLR[3];
      // } else {
      //   topLeftAlign = Alignment.topLeft;
      //   topRightAlign = Alignment.topRight;
      //   bottomCenterAlign = Alignment.bottomCenter;
      //   topCenterAlign = Alignment.topCenter;
      //
      //   topLeftList['top'] = topLeftTBLR[0];
      //   topLeftList['bottom'] = topLeftTBLR[1];
      //   topLeftList['left'] = topLeftTBLR[2];
      //   topLeftList['right'] = topLeftTBLR[3];
      //
      //   topRightList['top'] = topRightTBLR[0];
      //   topRightList['bottom'] = topRightTBLR[1];
      //   topRightList['left'] = topRightTBLR[2];
      //   topRightList['right'] = topRightTBLR[3];
      //
      //   bottomCenterList['top'] = bottomCenterTBLR[0];
      //   bottomCenterList['bottom'] = bottomCenterTBLR[1];
      //   bottomCenterList['left'] = bottomCenterTBLR[2];
      //   bottomCenterList['right'] = bottomCenterTBLR[3];
      //
      //   topCenterList['top'] = topCenterTBLR[0];
      //   topCenterList['bottom'] = topCenterTBLR[1];
      //   topCenterList['left'] = topCenterTBLR[2];
      //   topCenterList['right'] = topCenterTBLR[3];
      // }
    });
  }

  Container buildDot(int index, BuildContext context) {
    // Another Container returned
    return Container(
      height: 6,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorConstants.kPurpleCardMediumColor,
      ),
    );
  }
}

class SliderAniData {
  String? text;
  List<ImageData>? listOfImage;

  SliderAniData({this.text, this.listOfImage});
}

class ImageData {
  String? imageString;
  String? imageName;

  ImageData({this.imageString, this.imageName});
}

class GredientColorForAnimation {
  Color colo1;
  Color colo2;
  Color shadow;

  GredientColorForAnimation(
      {required this.colo1, required this.colo2, required this.shadow});
}
