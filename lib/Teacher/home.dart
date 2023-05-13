// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/loginController.dart';
import 'package:little_angels/Student/activities.dart';
import 'package:little_angels/Student/assignments.dart';
import 'package:little_angels/Student/attendance.dart';
import 'package:little_angels/Student/activity_details.dart';
import 'package:little_angels/Student/feeds.dart';
import 'package:little_angels/Student/message.dart';
import 'package:little_angels/Student/my_profile.dart';
import 'package:little_angels/Student/notification.dart';
import 'package:little_angels/Student/video.dart';
import 'package:little_angels/Student/view_events.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/todays_work.dart';
import 'package:little_angels/Teacher/Tests.dart';
import 'package:little_angels/Teacher/assignments.dart';
import 'package:little_angels/Teacher/attendance.dart';
import 'package:little_angels/Teacher/events.dart';
import 'package:little_angels/Teacher/feeds.dart';
import 'package:little_angels/Teacher/message.dart';
import 'package:little_angels/Teacher/notification.dart';
import 'package:little_angels/Teacher/profile.dart';
import 'package:little_angels/Teacher/time_table.dart';
import 'package:little_angels/Teacher/video.dart';
import 'package:little_angels/login_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_drawer.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../utils/network_handler.dart';

class TeacherHome extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherHome({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  var icon;
  var loginController = Get.put(LoginController());

  void showPopUpMenuAtTap(BuildContext context, TapDownDetails details) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
            value: '1',
            child: ListTile(
              onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                  context, TeacherProfile()),
              title: const Text("My Profile"),
              leading: SvgPicture.asset(
                AssetImages.drawerMyProfile,
                color: Colors.black,
              ),
            )),
        PopupMenuItem<String>(
          value: '2',
          child: ListTile(
            onTap: () {
                NetworkHandler.removeToken();
                Get.offAll(LoginPage());
                },
            title: const Text("Logout"),
            leading:
                SvgPicture.asset(AssetImages.drawerLogout, color: Colors.black),
          ),
        ),
      ],
      elevation: 8.0,
    ).then<void>((itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        //code here
      } else if (itemSelected == "2") {
        //code here
      } else {
        //code here
      }
    });
  }

  DateTime todayDate = DateTime.now();
  //final DateFormat formatter = DateFormat('EEEE');
  // final DateFormat formatter1 = DateFormat('dMMMM');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _data = [
    {
      'title': "View Feeds",
      'count': "0",
      'icon': AssetImages.drawerAssignment,
      'color': const LinearGradient(colors: [Colors.pink, Color(0xFFF48FB1)]),
      'page': const TeacherFeeds(
        id: '1',
        name: "Add Feeds",
      )
    },
    {
      'title': "Videos",
      'icon': AssetImages.video,
      'count': "1",
      'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
      'page': const TeacherVideo(
        id: '2',
        name: "Video",
      )
    },
    {
      'title': "Messages",
      'icon': AssetImages.messages,
      'count': "2",
      'color': const LinearGradient(colors: [Colors.red, Color(0xFFEF9A9A)]),
      'page': const TeacherMessage(
        id: '3',
        name: "Message",
      )
    },
    {
      'title': " Add Assignments",
      'icon': AssetImages.messageAssignment,
      'count': "3",
      'color': const LinearGradient(colors: [Colors.blue, Color(0xFF90CAF9)]),
      'page': const TeacherAssignments(
        id: '4',
        name: "Assignments",
      )
    },
    {
      'title': "Add & Check Test",
      'icon': AssetImages.todaysWork,
      'count': "4",
      'color': const LinearGradient(colors: [Colors.orange, Color(0xFFFFCC80)]),
      'page': const TeacherTest(
        id: '5',
        name: "Test",
      )
    },
    {
      'title': "Add Attendance",
      'icon': AssetImages.drawerAttendence,
      'count': "6",
      'color':
          const LinearGradient(colors: [Colors.deepPurple, Color(0xFFB39DDB)]),
      'page': const TeacherAttendance(
        id: '6',
        name: "Attendance",
      )
    },
    {
      'title': "Add Events",
      'icon': AssetImages.assessmentCert,
      'count': "6",
      'color': const LinearGradient(colors: [Colors.green, Color(0xFFA5D6A7)]),
      'page': const TeacherEvents(
        id: '7',
        name: "Add Events",
      )
    },
    {
      'title': "Time Table",
      'icon': AssetImages.assessmentCert,
      'count': "7",
      'color': const LinearGradient(colors: [Colors.pink, Color(0xFFF48FB1)]),
      'page': const TimeTable(
        id: '8',
        name: "View Events",
      )
    },
  ];

  final ScrollController scrollController = ScrollController();
  bool showBar = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkScroll();
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

  @override
  Widget build(BuildContext context) {
    MediaQuery gridView() => MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 16 / 9,
            ),
            itemCount: _data.length,
            itemBuilder: (context, index) => InkWell(
              splashColor: ColorConstants.kTransparentColor,
              highlightColor: ColorConstants.kTransparentColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _data[index]['page']),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    gradient: _data[index]['color'],
                    borderRadius: containeBorderRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _data[index]['count'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            smallSizedBox,
                            Text(
                              _data[index]['title'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              // textAlign: TextAlign.end,
                              style: buttonTextStyle,
                            ),
                          ],
                        ),
                      ),
                      _data[index]['icon']!.split('.').last == 'svg'
                          ? SvgPicture.asset(
                              _data[index]['icon']!,
                              width: 35.0,
                              height: 35.0,
                            )
                          : Image.asset(
                              _data[index]['icon']!,
                              width: 50.0,
                              height: 50.0,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

    welcomeText() => const Text(
          "TEACHER DASHBOARD",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            // decoration: TextDecoration.underline,
            // decorationThickness: 2.0,
            //decorationStyle: TextDecorationStyle.solid,
            // wordSpacing: 10,
            // shadows: [
            //   Shadow(
            //       color: Colors.black, blurRadius: 2.0, offset: Offset(3, 1))
            // ]
          ),
        );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 9, 38, 61),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AssetImages.splashLogo,
                height: 50,
                width: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                        context, const TeacherNotification()),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          AssetImages.drawerMyProfile,
                          color: Colors.green,
                          height: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(() => Text(
                        "${loginController.teacherName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                      GestureDetector(
                        onTapDown: (details) =>
                            showPopUpMenuAtTap(context, details),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 8, right: 8),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smallSizedBox,
                    smallSizedBox,
                    welcomeText(),
                    largeSizedBox,
                    gridView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
