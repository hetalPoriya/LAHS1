import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_angels/Student/assesment_certificate.dart';
import 'package:little_angels/Student/assignments.dart';
import 'package:little_angels/Student/attendance.dart';
import 'package:little_angels/Student/document.dart';
import 'package:little_angels/Student/feeds.dart';
import 'package:little_angels/Student/home_page.dart';
import 'package:little_angels/Student/message.dart';
import 'package:little_angels/Student/my_profile.dart';
import 'package:little_angels/Student/pickupcard.dart';
import 'package:little_angels/Student/report_card.dart';
import 'package:little_angels/Student/switchProfile.dart';
import 'package:little_angels/Student/video.dart';
import 'package:little_angels/Student/view_events.dart';
import 'package:little_angels/login_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/utility.dart';

import '../../Controller/loginController.dart';
import '../network_handler.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selected = 0;
  var loginController = Get.put(LoginController());

  void changeSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        //backgroundColor:const  Color.fromARGB(255, 28, 59, 94),
        child: Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.deepPurple, Color(0xFFB39DDB)])),
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: ListTile(
                trailing: InkWell(
                  child: SvgPicture.asset(
                    AssetImages.drawerHome,
                    height: 30,
                  ),
                  onTap: () =>
                      AnimatedNavigation.pushReplacementAnimatedNavigation(
                    context,
                    const StudentHome(),
                  ),
                ),
                title: Obx(
                  () => Text(
                    "Hi " + loginController.studentName.value,
                    textScaleFactor: 2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          // ListTile(
          //   dense: true,
          //   selected: _selected == 11,
          //   leading: GestureDetector(
          //       onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //           context, const MyProfile()),
          //       child: SvgPicture.asset(AssetImages.drawerMyProfile)),
          //   title: const Text(
          //     "My Profile",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: ()=>AnimatedNavigation.pushAnimatedNavigation(context,const  MyProfile()),
          //   onLongPress: () {
          //     changeSelected(11);
          //   },
          // ),
          // ListTile(
          //   dense: true,
          //   selected: _selected == 11,
          //   leading: GestureDetector(
          //       onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //           context, const MyProfile()),
          //       child: SvgPicture.asset(AssetImages.drawerMyProfile)),
          //   title: const Text(
          //     "Switch Profile",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: ()=>AnimatedNavigation.pushAnimatedNavigation(context,SwitchProfile()),
          //   onLongPress: () {
          //     changeSelected(11);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 1,
          //   leading: GestureDetector(
          //      onTap: () =>
          //           AnimatedNavigation.pushReplacementAnimatedNavigation(
          //             context,
          //             const StudentHome(),
          //           ),
          //     child: SvgPicture.asset(AssetImages.drawerFeeds)),
          //   title: const Text(
          //     "Feeds",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //   onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,
          //     const Feeds(),
          //   ) ,
          //    onLongPress: ()
          //     {
          //     changeSelected(1);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 2,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const Message(),
          //           ),
          //       child: SvgPicture.asset(AssetImages.drawerMessages)),
          //   title: const Text(
          //     "Message",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          //    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,
          //     const Message(),
          //   ),
          //    onLongPress: () {
          //     changeSelected(2);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 3,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const Assignments(),
          //           ),
          //     child: SvgPicture.asset(AssetImages.drawerAssignment)),
          //   title: const Text(
          //     "Assignment",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,
          //     const Assignments(),
          //   ),
          //    onLongPress: () {
          //     changeSelected(3);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 4,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const Documents(),
          //           ),
          //     child: SvgPicture.asset(AssetImages.drawerDocument)),
          //   title: const Text(
          //     "Documents",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: ()=> AnimatedNavigation.pushAnimatedNavigation(context, const Documents(),),
          //    onLongPress: () {
          //     changeSelected(4);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 5,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const Attendance(),
          //           ),
          //       child: SvgPicture.asset(AssetImages.drawerAttendence)),
          //   title: const Text(
          //     "Attendance",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //     onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,
          //     const Attendance(),
          //   ),
          //    onLongPress: () {
          //     changeSelected(5);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 6,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const ViewEvents(),
          //           ),
          //     child: SvgPicture.asset(AssetImages.drawerViewEvents)),
          //   title: const Text(
          //     "View Events",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,
          //     const ViewEvents(),
          //   ),
          //    onLongPress: () {
          //     changeSelected(6);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 7,
          //   leading: SvgPicture.asset(AssetImages.drawerAssessmentCertificate),
          //   title: const Text(
          //     "Assesment Certificate",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //    onTap: () {
          //      AnimatedNavigation.pushAnimatedNavigation(
          //          context, AssesmentCertificate());
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 8,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //           context, const Video()),
          //     child: SvgPicture.asset(AssetImages.drawerVideo)),
          //   title: const Text(
          //     "Videos",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //     context,const Video()),
          //    onLongPress: () {
          //     changeSelected(8);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //   selected: _selected == 9,
          //   leading: GestureDetector(
          //      onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //           context, const ReportCard()),
          //     child: SvgPicture.asset(AssetImages.drawerReportCard)),
          //   title: const Text(
          //     "Report Card",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //       context, const ReportCard()),
          //    onLongPress: () {
          //     changeSelected(9);
          //   },
          // ),
          // ListTile(
          //    dense: true,
          //  selected: _selected == 10,
          //   leading: GestureDetector(
          //     onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //             context,
          //             const Pickupcard(),
          //           ),
          //     child: SvgPicture.asset(AssetImages.drawerPickUpCard)),
          //   title: const Text(
          //     "Pickup Card",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: ()=> AnimatedNavigation.pushAnimatedNavigation(context, const Pickupcard(),),
          //    onLongPress: ()
          //
          //    {
          //  changeSelected(10);
          //   },
          // ),
          /*ListTile(
             dense: true,
            selected: _selected == 12,
            leading: GestureDetector(
               onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      const SwitchProfile(),
                    ),
              child: SvgPicture.asset(AssetImages.drawerSwitchProfile)),
            title: const Text(
              "Switch Profile",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
             onTap: () => AnimatedNavigation.pushAnimatedNavigation(
              context,
              const SwitchProfile(),
            ),
             onLongPress: () {
              changeSelected(12);
            },
          ),*/
          ListTile(
            dense: true,
            selected: _selected == 11,
            leading: GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context, const MyProfile()),
                child: SvgPicture.asset(AssetImages.drawerMyProfile)),
            title: const Text(
              "Profile",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                context, const MyProfile()),
            onLongPress: () {
              changeSelected(11);
            },
          ),
          ListTile(
            dense: true,
            selected: _selected == 11,
            leading: GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context, const MyProfile()),
                child: SvgPicture.asset(AssetImages.drawerMyProfile)),
            title: const Text(
              "Switch Profile",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                context, SwitchProfile()),
            onLongPress: () {
              changeSelected(11);
            },
          ),

          ListTile(
            dense: true,
            selected: _selected == 7,
            leading: SvgPicture.asset(AssetImages.certificateSvg),
            title: const Text(
              "Certificate",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              AnimatedNavigation.pushAnimatedNavigation(
                  context, AssesmentCertificate());
            },
          ),
          ListTile(
            dense: true,
            selected: _selected == 9,
            leading: GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context, const ReportCard()),
                child: SvgPicture.asset(AssetImages.drawerReportCard)),
            title: const Text(
              "Report Card",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                context, const ReportCard()),
            onLongPress: () {
              changeSelected(9);
            },
          ),
          // ListTile(
          //   dense: true,
          //   selected: _selected == 9,
          //   leading: GestureDetector(
          //       onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //           context, const ReportCard()),
          //       child: SvgPicture.asset(AssetImages.uploadSvg)),
          //   title: const Text(
          //     "Uploads",
          //     textScaleFactor: 1.2,
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   // onTap: () => AnimatedNavigation.pushAnimatedNavigation(
          //   //     context, const ReportCard()),
          //   // onLongPress: () {
          //   //   changeSelected(9);
          //   // },
          // ),
          ListTile(
            dense: true,
            selected: _selected == 5,
            leading: GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      const Attendance(),
                    ),
                child: SvgPicture.asset(AssetImages.attendanceSvg)),
            title: const Text(
              "Attendance",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => AnimatedNavigation.pushAnimatedNavigation(
              context,
              const Attendance(),
            ),
            onLongPress: () {
              changeSelected(5);
            },
          ),

          ListTile(
            dense: true,
            selected: _selected == 10,
            leading: GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      const Pickupcard(),
                    ),
                child: SvgPicture.asset(AssetImages.drawerPickUpCard)),
            title: const Text(
              "Pick up Card",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => AnimatedNavigation.pushAnimatedNavigation(
              context,
              const Pickupcard(),
            ),
            onLongPress: () {
              changeSelected(10);
            },
          ),
          ListTile(
            dense: true,
            selected: _selected == 13,
            leading: GestureDetector(
                onTap: () {
                  NetworkHandler.removeToken();
                  Get.offAll(LoginPage());
                },
                child: SvgPicture.asset(AssetImages.drawerLogout)),
            title: const Text(
              "Logout",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              NetworkHandler.removeToken();
              Get.offAll(LoginPage());
            },
            onLongPress: () {
              changeSelected(13);
            },
          ),
        ],
      ),
    ));
  }
}

//
// InkWell(
// splashColor: ColorConstants.kTransparentColor,
// highlightColor: ColorConstants.kTransparentColor,
// onTap: () {
// dailyActivityController.stuUpdateCounter("message");
// dailyActivityController.messageCount(0);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const Message(
// name: "Message",
// )),
// );
// },
// child: Padding(
// padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
// child: Container(
// decoration: BoxDecoration(
// gradient: const LinearGradient(
// colors: [Colors.red, Color(0xFFEF9A9A)]),
// borderRadius: containeBorderRadius,
// ),
// child: Obx(() => dailyActivityController.isLoading.value
// ? ShimmerWidget.rectangular(
// width: MediaQuery.of(context).size.width,
// height: MediaQuery.of(context).size.height,
// )
//     : Badge(
// showBadge:
// dailyActivityController.messageCount != 0
// ? true
//     : false,
// badgeContent: SizedBox(
// width: 20, //height: 20, //badge size
// child: Center(
// //aligh badge content to center
// child: Text(
// "${dailyActivityController.messageCount}",
// style: TextStyle(
// color:
// Colors.white, //badge font color
// fontSize: 20 //badge font size
// )),
// )),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(
// AssetImages.messages,
// width: 50.0,
// height: 50.0,
// ),
// Text(
// "Messages",
// maxLines: 1,
// textAlign: TextAlign.center,
// style: buttonTextStyle,
// ),
// ],
// ),
// )),
// )),
// ),
