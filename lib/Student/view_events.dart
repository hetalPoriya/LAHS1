// // ignore_for_file: unused_import
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/event_details.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../Controller/calEventController.dart';
import '../utils/animated_navigation.dart';
import '../utils/network_handler.dart';

class ViewEvents extends StatefulWidget {
  final String? name;
  const ViewEvents({Key? key, this.name}) : super(key: key);

  @override
  State<ViewEvents> createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  var calEventController = Get.put(CalEventController());
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        calEventController.getStuEvent();
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

  final List<Map<String, dynamic>> _eventslist = [
    {'title': 'Surfing', 'Description': 'abc'},
    {'title': 'Runnig', 'Description': 'abc'},
    {'title': 'Tennis', 'Description': 'abc'},
    {'title': 'Surfing', 'Description': 'abc'},
    {'title': 'Runnig', 'Description': 'abc'},
    {'title': 'Tennis', 'Description': 'abc'},
  ];
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Obx(() => calEventController.isLoading == true
            ? Center(
                child: Image.asset(
                  "assets/loading.gif",
                  height: 425.0,
                  width: 425.0,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Events list".toUpperCase(),
                    style: titleTextStyle,
                    // textAlign: TextAlign.start,
                  ),
                  divider,
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      // removeBottom: true,
                      // removeBottom: true,
                      child: calEventController.calender_events.length == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/no-data.gif"),
                                smallSizedBox,
                                Text(
                                  "There are no events",
                                  style: TextStyle(color: Colors.purple[800]),
                                )
                              ],
                            )
                          : calEventController.status ==
                                  "Calender events not found"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/no-data.gif"),
                                    smallSizedBox,
                                    Text(
                                      "There are no events",
                                      style:
                                          TextStyle(color: Colors.purple[800]),
                                    )
                                  ],
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      calEventController.calender_events.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          AnimatedNavigation
                                              .pushAnimatedNavigation(
                                                  context,
                                                  EventDetails(
                                                    id: index,
                                                  ));
                                        },
                                        child: Card(
                                          color: ColorConstants.kGreyColor100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                smallerSizedBox,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      calEventController
                                                          .calender_events[
                                                              index]
                                                          .eventTitle,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Text(
                                                            DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(calEventController
                                                                    .calender_events[
                                                                        index]
                                                                    .eventDate),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                mediumSizedBox,
                                                Text(
                                                  calEventController
                                                      .calender_events[index]
                                                      .eventDescription,
                                                ),
                                                smallerSizedBox,
                                              ],
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 400),
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: _events.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         color: ColorConstants.kGreyColor100,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 _events[index]['title'],
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontWeight: FontWeight.bold),
                  //               ),
                  //               smallSizedBox,
                  //               Text(
                  //                 DateFormat('dd-MM-yyyy      hh:mm:ss')
                  //                     .format(DateTime.now()),
                  //                 style: TextStyle(color: Colors.grey),
                  //               ),

                  //               const SizedBox(height: 30),
                  //               Text(
                  //                 _events[index]['Description'],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // const TabBar(
                  //   tabs: [
                  //     Tab(
                  //       text: "News & Events",
                  //     ),
                  //     Tab(
                  //       text: "others",
                  //     ),
                  //   ],
                  // isScrollable: true,
                  //   labelColor: ColorConstants.kBlackColor,
                  //   labelStyle: TextStyle(fontSize: 18),
                  //   unselectedLabelColor: ColorConstants.kBlackColor,

                  // ),
                  // const SizedBox(height: 10),
                  // buildTabBarView(),
                ],
              )),
      ),
    );
    //   ),
    // );
  }
}

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:little_angels/Student/subjects.dart';
// import 'package:little_angels/utils/animated_navigation.dart';
// import 'package:little_angels/utils/colors.dart';
// import 'package:little_angels/utils/widgets/custom_page.dart';
// import 'package:little_angels/utils/images.dart';
// import 'package:little_angels/utils/strings.dart';
// import 'package:little_angels/utils/utility.dart';
// import 'package:table_calendar/table_calendar.dart';

// class ViewEvents  extends StatefulWidget {
//   final String? id;
//   final String? name;
//   const ViewEvents({Key? key, this.id, this.name}) : super(key: key);

//   @override
//   State<ViewEvents> createState() => _ViewEventsState();
// }

// class _ViewEventsState extends State< ViewEvents> {
//   DateTime todayDate = DateTime.now();
//   final DateFormat formatter = DateFormat('EEEE');
//   final DateFormat formatter1 = DateFormat('dMMMM');

//   nameText() => Text("Calendar".toUpperCase(), style: titleTextStyle);

//   dateText() => Text(
//         DateFormat('dd-MM-yyyy').format(DateTime.now()),
//         style: textButtonTextStyle,
//       );

//   calendarWidget() => Container(
//     height: 285,
//       decoration:const  BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Colors.grey,width:1),
//           left: BorderSide(color: Colors.grey, width: 1),
//           bottom: BorderSide(color: Colors.grey, width: 1),
//           right: BorderSide(color: Colors.grey, width: 1),
//         ),

//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
//         child:
//         TableCalendar(
//           rowHeight: 30.0,
//           headerVisible: true,
//           daysOfWeekHeight: 60.0,
//         startingDayOfWeek: StartingDayOfWeek.sunday,
//           headerStyle:const HeaderStyle(
//             titleTextStyle: TextStyle(
//               fontSize: 20,fontWeight: FontWeight.bold),
//            headerPadding: EdgeInsets.symmetric(horizontal: 20),
//             formatButtonVisible: false,
//             leftChevronVisible: false,
//             rightChevronVisible: false,

//           ),
//           daysOfWeekStyle: const DaysOfWeekStyle(
//               weekdayStyle:
//                   TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
//               weekendStyle:
//                   TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
//           calendarStyle: const CalendarStyle(
//               markerSizeScale: 1.3,
//               todayDecoration: BoxDecoration(
//                   color: ColorConstants.kHeadingTextColor,
//                   shape: BoxShape.circle),
//               todayTextStyle:
//                   TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
//               selectedTextStyle:
//                   TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
//               outsideTextStyle:
//                   TextStyle(color: Colors.grey, fontSize: 12.0),
//               weekendTextStyle:
//                   TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
//               defaultTextStyle:
//                   TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
//           firstDay: DateTime.utc(1999, 10, 16),
//           lastDay: DateTime.utc(2030, 3, 14),
//           focusedDay: DateTime.now(),
//           calendarBuilders: CalendarBuilders(
//             dowBuilder: (context, day) {
//               final text = DateFormat.E().format(day);
//               return Center(
//                 child: Text(
//                   text.substring(0, 1).toUpperCase(),
//                   style: const TextStyle(color: ColorConstants.kBlackColor),
//                 ),
//               );
//             },
//             todayBuilder: (context, date, _) {
//               return Container(
//                 // margin: const EdgeInsets.all(4.0),
//                 padding: const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
//                 decoration: BoxDecoration(
//                     color: ColorConstants.kHeadingTextColor,
//                     borderRadius: BorderRadius.circular(50.0)),
//                 // width: 100,
//                 // height: 100,
//                 child: Text(
//                   '${date.day}',
//                   style: const TextStyle(
//                       color: ColorConstants.kWhiteColor, fontSize: 12.0),
//                 ),
//               );
//             },
//           ),
//         ),
//       ));

//   calendarContainerWidget() => Container(
//       height: MediaQuery.of(context).size.height / 2.4,
//       decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//           border: Border.all(color: Colors.black26)),
//       child: calendarWidget()
//          );
//   subjectButton() => CustomElevatedButton(
//         endColor: Colors.blue,
//         beginColor: Colors.blue,
//         height: 45.0,
//         width: double.infinity,
//         onPressed: () {},
//         borderRadius: BorderRadius.circular(20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(DateFormat('EEEE').format(todayDate).toString()),
//             Text(DateFormat('dd MMM yyyy').format(todayDate).toString()),
//           ],
//         ),
//       );

//   timewidget() => Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 Text(DateFormat().add_jm().format(todayDate).toString(),
//                  style: const TextStyle(color: Colors.grey),
//                 ),
//                 Text(DateFormat().add_jm().format(todayDate).toString(),
//                  style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 30.0,
//             width: 3.0,
//             color: Colors.blue,
//           ),
//           const SizedBox(width: 5),
//           const Expanded(
//               flex: 4, child: Text("Regular School Timings for New Students",
//                style:  TextStyle(color: Colors.grey),
//               ))
//         ],
//       );

//   textwidget() => Row(
//         // ignore: prefer_const_literals_to_create_immutables
//         children: [
//           const Expanded(child: Text("All day",
//            style:  TextStyle(color: Colors.grey),
//           )),
//           Container(height: 30.0, width: 3.0, color: Colors.blue),
//           const SizedBox(
//             width: 5,
//           ),
//           const Expanded(flex: 4, child: Text("Health day celebration",
//            style:  TextStyle(color: Colors.grey),))
//         ],
//       );
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             customSizedBox(100.0),
//             nameText(),
//             smallSizedBox,
//             dateText(),
//             smallSizedBox,
//             divider,
//             mediumSizedBox,
//             calendarWidget(),
//             largeSizedBox,
//             subjectButton(),
//             smallSizedBox,
//             timewidget(),
//             smallSizedBox,
//             divider,
//             smallSizedBox,
//             textwidget(),
//             smallSizedBox,
//             divider,
//             smallSizedBox,
//           ],
//         ),
//       ),
//     );
//   }
// }
