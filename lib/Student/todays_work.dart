// // ignore_for_file: unnecessary_import, unused_import
//
// import 'dart:ui';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:little_angels/Controller/assignmentController.dart';
// import 'package:little_angels/Controller/todaysWorkController.dart';
// import 'package:little_angels/Student/subjects.dart';
// import 'package:little_angels/utils/animated_navigation.dart';
// import 'package:little_angels/utils/colors.dart';
// import 'package:little_angels/utils/network_handler.dart';
// import 'package:little_angels/utils/widgets/custom_page.dart';
// import 'package:little_angels/utils/images.dart';
// import 'package:little_angels/utils/strings.dart';
// import 'package:little_angels/utils/utility.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class TodaysWork extends StatefulWidget {
//   final String? name;
//
//   const TodaysWork({Key? key, this.name}) : super(key: key);
//
//   @override
//   State<TodaysWork> createState() => _TodaysWorkState();
// }
//
// class _TodaysWorkState extends State<TodaysWork> with TickerProviderStateMixin {
//   DateTime todayDate = DateTime.now();
//   final DateFormat formatter = DateFormat('EEEE');
//   final DateFormat formatter1 = DateFormat('dMMMM');
//   var isCalVisible = false;
//   var todaysWorkController = Get.put(TodaysWorkController());
//   NetworkHandler nr = NetworkHandler();
//
//   DateTime _selectedDay = DateTime.now();
//   DateTime? _focusedDay = DateTime.now();
//
//   Animation? animation;
//   Animation? animation1;
//   AnimationController? animationController, animationController1;
//
//   bool alignWidget = false;
//   Alignment alignment1 = Alignment.topLeft;
//   Alignment alignment2 = Alignment.bottomCenter;
//   Alignment alignment3 = Alignment.topRight;
//   int swipeLeft = 0;
//
//   initState() {
//     _init();
//     animationController =
//         new AnimationController(vsync: this, duration: Duration(seconds: 1));
//     animationController1 =
//         new AnimationController(vsync: this, duration: Duration(seconds: 1));
//     animation = Tween(begin: 0.0, end: 0.0).animate(animationController!);
//     animation1 = Tween(begin: 0.0, end: 0.0).animate(animationController1!);
//     // animationController?.forward();
//     super.initState();
//   }
//
//   _init() async {
//     bool isConnected = await nr.checkConnectivity();
//     print(isConnected);
//     if (isConnected) {
//       todaysWorkController.getStuTodaysWork();
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
//   nameText() => Text(widget.name.toString(), style: titleTextStyle);
//
//   dateText() => Text(
//         DateFormat('dd MMMM yyyy').format(DateTime.now()),
//         style: textButtonTextStyle,
//       );
//
//   calendarWidget() => Visibility(
//       visible: isCalVisible,
//       child: Container(
//           height: 285,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             border: Border(
//               top: BorderSide(color: Colors.grey, width: 1),
//               left: BorderSide(color: Colors.grey, width: 1),
//               bottom: BorderSide(color: Colors.grey, width: 1),
//               right: BorderSide(color: Colors.grey, width: 1),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
//             child: TableCalendar(
//               rowHeight: 30.0,
//               headerVisible: true,
//               daysOfWeekHeight: 60.0,
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDay, day);
//               },
//               onDaySelected: (selectedDay, focusedDay) {
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay; // update `_focusedDay` here as well
//                 });
//               },
//               startingDayOfWeek: StartingDayOfWeek.sunday,
//               headerStyle: const HeaderStyle(
//                 titleTextStyle:
//                     TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 headerPadding: EdgeInsets.symmetric(horizontal: 18),
//                 formatButtonVisible: false,
//                 leftChevronVisible: false,
//                 rightChevronVisible: false,
//               ),
//               daysOfWeekStyle: const DaysOfWeekStyle(
//                   weekdayStyle: TextStyle(
//                       color: ColorConstants.kWhiteColor, fontSize: 12.0),
//                   weekendStyle: TextStyle(
//                       color: ColorConstants.kBlackColor, fontSize: 12.0)),
//               calendarStyle: const CalendarStyle(
//                   markerSizeScale: 1.3,
//                   todayDecoration: BoxDecoration(
//                       color: ColorConstants.kHeadingTextColor,
//                       shape: BoxShape.circle),
//                   todayTextStyle: TextStyle(
//                       color: ColorConstants.kWhiteColor, fontSize: 12.0),
//                   selectedTextStyle: TextStyle(
//                       color: ColorConstants.kBlackColor, fontSize: 12.0),
//                   outsideTextStyle:
//                       TextStyle(color: Colors.grey, fontSize: 12.0),
//                   weekendTextStyle: TextStyle(
//                       color: ColorConstants.kBlackColor, fontSize: 12.0),
//                   defaultTextStyle: TextStyle(
//                       color: ColorConstants.kBlackColor, fontSize: 12.0)),
//               firstDay: DateTime.utc(1999, 10, 16),
//               lastDay: DateTime.utc(2030, 3, 14),
//               focusedDay: _focusedDay!,
//               calendarBuilders: CalendarBuilders(
//                 dowBuilder: (context, day) {
//                   final text = DateFormat.E().format(day);
//                   return Center(
//                     child: Text(
//                       text.substring(0, 1).toUpperCase(),
//                       style: const TextStyle(color: ColorConstants.kBlackColor),
//                     ),
//                   );
//                 },
//                 selectedBuilder: (context, date, _) {
//                   return Container(
//                     padding: const EdgeInsets.only(
//                         left: 7, right: 7, top: 4, bottom: 4),
//                     decoration: BoxDecoration(
//                         color: ColorConstants.kGreyColor,
//                         borderRadius: BorderRadius.circular(50.0)),
//                     child: Text(
//                       '${date.day}',
//                       style: const TextStyle(
//                           color: ColorConstants.kWhiteColor, fontSize: 12.0),
//                     ),
//                   );
//                 },
//                 todayBuilder: (context, date, _) {
//                   return Container(
//                     padding: const EdgeInsets.only(
//                         left: 7, right: 7, top: 4, bottom: 4),
//                     decoration: BoxDecoration(
//                         color: ColorConstants.kHeadingTextColor,
//                         borderRadius: BorderRadius.circular(50.0)),
//                     child: Text(
//                       '${date.day}',
//                       style: const TextStyle(
//                           color: ColorConstants.kWhiteColor, fontSize: 12.0),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )));
//
//   calendarContainerWidget() => Container(
//       height: MediaQuery.of(context).size.height / 2.4,
//       decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//           border: Border.all(color: Colors.black26)),
//       child: calendarWidget());
//
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
//             Text(DateFormat('EEEE').format(_selectedDay).toString()),
//             Text(DateFormat('dd MMM yyyy').format(_selectedDay).toString()),
//           ],
//         ),
//       );
//
//   timewidget() => Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: [
//                 Text(
//                   DateFormat().add_jm().format(todayDate).toString(),
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//                 Text(
//                   DateFormat().add_jm().format(todayDate).toString(),
//                   style: const TextStyle(color: Colors.grey),
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
//             flex: 4,
//             child: Text(
//               "Regular School Timings for New Students",
//               style: TextStyle(color: Colors.grey),
//             ),
//           )
//         ],
//       );
//
//   textwidget() => Column(
//         children: [
//           for (var i = 0; i < todaysWorkController.todayWork.length; i++)
//             if (DateFormat("dd-MM-yy")
//                     .format(todaysWorkController.todayWork[i].workDate)
//                     .compareTo(DateFormat("dd-MM-yy").format(_selectedDay)) ==
//                 0)
//               Column(
//                 children: [
//                   Row(
//                     // ignore: prefer_const_literals_to_create_immutables
//                     children: [
//                       Expanded(
//                           child: Text(
//                         "${todaysWorkController.todayWork[i].subjectsName}",
//                         style: TextStyle(color: Colors.grey),
//                       )),
//                       Container(height: 30.0, width: 3.0, color: Colors.blue),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                           flex: 4,
//                           child: Text(
//                             "${todaysWorkController.todayWork[i].description}",
//                             style: TextStyle(color: Colors.grey),
//                           ))
//                     ],
//                   ),
//                   smallSizedBox,
//                   Divider(),
//                 ],
//               )
//         ],
//       );
//
//   final List<Map<String, dynamic>> _data = [
//     {
//       'name': Strings.todayWork,
//       'image1': Image.asset(AssetImages.calendarAniCard),
//       'image2': Image.asset(AssetImages.calendarAniCard),
//       'image3': Image.asset(AssetImages.assignment),
//     },
//     {
//       'name': Strings.assignment,
//       'image1': Image.asset(AssetImages.subjectAniCard),
//       'image2': Image.asset(AssetImages.assignment),
//       'image3': Image.asset(AssetImages.calendarAniCard),
//     },
//     {
//       'name': Strings.subjects,
//       'image1': Image.asset(AssetImages.assignment),
//       'image2': Image.asset(AssetImages.subjectAniCard),
//       'image3': Image.asset(AssetImages.calendarAniCard),
//     },
//     {
//       'name': Strings.calender,
//       'image1': Image.asset(AssetImages.subjectAniCard),
//       'image2': Image.asset(AssetImages.calendarAniCard),
//       'image3': Image.asset(AssetImages.calendarAniCard),
//     }
//   ];
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   print("inside widget");
//   //   print(DateFormat("dd-MM-yy").format(_selectedDay));
//   //   return CustomScaffold(
//   //     child: Obx(
//   //   () => todaysWorkController.isLoading ==true?
//   //   Center(
//   //       child: Image.asset(
//   //         "assets/loading.gif",
//   //         height: 425.0,
//   //         width: 425.0,
//   //         fit: BoxFit.fitHeight,
//   //       )
//   //   ): SingleChildScrollView(
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           customSizedBox(100.0),
//   //           nameText(),
//   //           smallSizedBox,
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               dateText(),
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   setState(() {
//   //                     isCalVisible == false ?isCalVisible = true : isCalVisible = false;
//   //                   });
//   //                 },
//   //                 child: Container(
//   //                   height: 40,
//   //                   width: 40,
//   //                   child: Padding(
//   //                     padding: EdgeInsets.all(5),
//   //                     child: SvgPicture.asset(
//   //                       AssetImages.calendar,
//   //                       height: 20,
//   //                     ),
//   //                   ),
//   //               ),
//   //               )
//   //             ],
//   //           ),
//   //           smallSizedBox,
//   //           divider,
//   //           mediumSizedBox,
//   //           calendarWidget(),
//   //           largeSizedBox,
//   //           subjectButton(),
//   //           smallSizedBox,
//   //           smallSizedBox,
//   //           textwidget(),
//   //           smallSizedBox,
//   //         ],
//   //       ),
//   //     )),
//   //   );
//   // }
//
//   sliderWidget({
//     String? text,
//   }) {
//     return Container(
//       alignment: Alignment.center,
//       height: 200.0,
//       width: 390.0,
//       margin: EdgeInsets.symmetric(horizontal: 19.0),
//       decoration: BoxDecoration(
//           borderRadius: containeBorderRadius,
//           gradient: LinearGradient(colors: [
//             ColorConstants.kPurpleCardDarkColor,
//             ColorConstants.kPurpleCardMediumColor,
//             ColorConstants.kPurpleCardLightColor,
//           ])),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(AssetImages.userCard, height: 80.0, width: 100.0),
//           smallSizedBox,
//           Text('${text}',
//               style: titleTextStyle.copyWith(
//                   color: Colors.white, fontWeight: kFontWeight400)),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("inside widget");
//     print(DateFormat("dd-MM-yy").format(_selectedDay));
//     return CustomScaffold(
//       child: Obx(
//         () => todaysWorkController.isLoading == true
//             ? Center(
//                 child: Image.asset(
//                 "assets/loading.gif",
//                 height: 425.0,
//                 width: 425.0,
//                 fit: BoxFit.fitHeight,
//               ))
//             : Column(
//                 children: [
//                   customSizedBox(100.0),
//                   //           nameText(),
//                   smallSizedBox,
//                   Flexible(
//                     flex: 2,
//                     child: CarouselSlider.builder(
//                       itemCount: 4,
//                       itemBuilder: (context, index, inde) {
//                         return sliderWidget(text: _data[index]['name']);
//                       },
//                       options: CarouselOptions(
//                         disableCenter: true,
//                         pageSnapping: true,
//                         viewportFraction: 0.9,
//                         onPageChanged: (data, val) {
//                           setState(() {
//                             alignWidget = !alignWidget;
//                             print('Alignment $alignment1');
//                             if (alignment1 == Alignment.topLeft) {
//                               print('LEFT');
//                               setState(() {
//                                 alignment1 = Alignment.topRight;
//                                 alignment2 = Alignment.topLeft;
//                                 alignment3 = Alignment.bottomCenter;
//                               });
//                             } else if (alignment1 == Alignment.topRight) {
//                               setState(() {
//                                 print('RIGHT');
//                                 alignment1 = Alignment.bottomCenter;
//                                 alignment2 = Alignment.topRight;
//                                 alignment3 = Alignment.topLeft;
//                               });
//                             } else if (alignment1 == Alignment.bottomCenter) {
//                               setState(() {
//                                 print('Bottom');
//                                 alignment1 = Alignment.topLeft;
//                                 alignment2 = Alignment.bottomCenter;
//                                 alignment3 = Alignment.topRight;
//                               });
//                             }
//                             print(alignment1);
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       flex: 3,
//                       child: Stack(
//                         children: [
//                           AnimatedPositioned(
//                             duration: Duration(seconds: 1),
//                             top: 0.0,
//                             left: alignWidget ? 252.0 : 0.0,
//                             child: Container(
//                               //color: Colors.white,
//                               height: 120.0,
//                               width: 120.0,
//                               child: AnimatedAlign(
//                                 alignment: alignment1,
//                                 duration: Duration(seconds: 1),
//                                 child: Image.asset(
//                                   AssetImages.assignmentAniCard,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           AnimatedPositioned(
//                             duration: Duration(seconds: 1),
//                             bottom: alignWidget ? 190.0 : 0.0,
//                             left: alignWidget ? 0 : 125.0,
//                             child: Container(
//                               height: 120.0,
//                               width: 120.0,
//                               child: AnimatedAlign(
//                                 alignment: alignment2,
//                                 duration: Duration(seconds: 1),
//                                 child: Image.asset(
//                                   AssetImages.calendarAniCard,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           AnimatedPositioned(
//                             bottom: alignWidget ? 0.0 : 190.0,
//                             right: alignWidget ? 125.0 : 0.0,
//                             duration: Duration(seconds: 1),
//                             child: Container(
//                               //  color: Colors.green,
//                               height: 120.0,
//                               width: 120.0,
//                               child: AnimatedAlign(
//                                 alignment: alignment3,
//                                 duration: Duration(seconds: 1),
//                                 child: Image.asset(
//                                   AssetImages.subjectAniCard,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                   Expanded(
//                       flex: 2,
//                       child: Container(
//                           //color: Colors.grey,
//                           ))
//                 ],
//               ),
//       ),
//     );
//   }
// }
// ignore_for_file: unnecessary_import, unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/assignmentController.dart';
import 'package:little_angels/Controller/todaysWorkController.dart';
import 'package:little_angels/Student/subjects.dart';
import 'package:little_angels/Student/todays_word_dateWise_data.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/student/app_widget.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:table_calendar/table_calendar.dart';

class TodaysWork extends StatefulWidget {
  final String? name;
  const TodaysWork({Key? key, this.name}) : super(key: key);

  @override
  State<TodaysWork> createState() => _TodaysWorkState();
}

class _TodaysWorkState extends State<TodaysWork> {
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  var isCalVisible = false;
  var todaysWorkController = Get.put(TodaysWorkController());
  NetworkHandler nr = NetworkHandler();

  DateTime _selectedDay = DateTime.now();
  DateTime? _focusedDay = DateTime.now();

  initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      todaysWorkController.getStuTodaysWork();
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

  //nameText() => Text(widget.name.toString(), style: titleTextStyle);
  nameText() => Text("Today's Work", style: titleTextStyle);

  dateText() => Text(
        DateFormat('dd MMMM yyyy').format(DateTime.now()),
        style: textButtonTextStyle,
      );

  calendarWidget() => Visibility(
      visible: isCalVisible,
      child: Container(
          height: 320,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 30.0,
                    offset: Offset(0.0, 0.0))
              ]
              // border: Border(
              //   top: BorderSide(color: Colors.grey, width: 1),
              //   left: BorderSide(color: Colors.grey, width: 1),
              //   bottom: BorderSide(color: Colors.grey, width: 1),
              //   right: BorderSide(color: Colors.grey, width: 1),
              // ),
              ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
            child: TableCalendar(
              rowHeight: 30.0,
              headerVisible: true,
              daysOfWeekHeight: 65.0,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => TodaysWorkDateWiseData(
                              date: _selectedDay,
                              todaysWorkController: todaysWorkController))));
                });
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                headerPadding: EdgeInsets.symmetric(horizontal: 18),
                formatButtonVisible: false,
                titleCentered: true,

                // leftChevronVisible: false,
                // rightChevronVisible: false,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      color: ColorConstants.kWhiteColor, fontSize: 12.0),
                  weekendStyle: TextStyle(
                      color: ColorConstants.kBlackColor, fontSize: 12.0)),
              calendarStyle: const CalendarStyle(
                  markerSizeScale: 1.3,
                  todayDecoration: BoxDecoration(
                      color: ColorConstants.kHeadingTextColor,
                      shape: BoxShape.circle),
                  todayTextStyle: TextStyle(
                      color: ColorConstants.kWhiteColor, fontSize: 12.0),
                  selectedTextStyle: TextStyle(
                      color: ColorConstants.kBlackColor, fontSize: 12.0),
                  outsideTextStyle:
                      TextStyle(color: Colors.grey, fontSize: 12.0),
                  weekendTextStyle: TextStyle(
                      color: ColorConstants.kBlackColor, fontSize: 12.0),
                  defaultTextStyle: TextStyle(
                      color: ColorConstants.kBlackColor, fontSize: 12.0)),
              firstDay: DateTime.utc(1999, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay!,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text.toUpperCase(),
                      style: TextStyle(
                          color: ColorConstants.kGreyColor400, fontSize: 12),
                    ),
                  );
                },
                selectedBuilder: (context, date, _) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: ColorConstants.kGreyColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: ColorConstants.kHeadingTextColor,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                },
              ),
            ),
          )));

  calendarContainerWidget() => Container(
      height: MediaQuery.of(context).size.height / 2.4,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: Colors.black26)),
      child: calendarWidget());

  subjectButton() => CustomElevatedButton(
        endColor: Colors.blue,
        beginColor: Colors.blue,
        height: 45.0,
        width: double.infinity,
        onPressed: () {},
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('EEEE').format(_selectedDay!).toString()),
            Text(DateFormat('dd MMM yyyy').format(_selectedDay!).toString()),
          ],
        ),
      );

  timewidget() => Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  DateFormat().add_jm().format(todayDate).toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  DateFormat().add_jm().format(todayDate).toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            height: 30.0,
            width: 3.0,
            color: Colors.blue,
          ),
          const SizedBox(width: 5),
          const Expanded(
            flex: 4,
            child: Text(
              "Regular School Timings for New Students",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      );

  textwidget() {
    // print('DATA ${todaysWorkController.todayWork[1].subjectsName}');
    // print('DATA ${todaysWorkController.todayWork[1].description}');
    return Column(
      children: [
        for (var i = 0; i < todaysWorkController.todayWork.length; i++)
          if (DateFormat("dd-MM-yy")
                  .format(todaysWorkController.todayWork[i].workDate)
                  .compareTo(DateFormat("dd-MM-yy").format(_selectedDay)) ==
              0)
            AppWidgets.todaysWorkContainer(
                subjectName: todaysWorkController.todayWork[i].subjectsName,
                description: todaysWorkController.todayWork[i].description)

        // Column(
        //   children: [
        //     Row(
        //       // ignore: prefer_const_literals_to_create_immutables
        //       children: [
        //         Expanded(
        //             child: Text(
        //           "${todaysWorkController.todayWork[i].subjectsName}",
        //           style: TextStyle(color: Colors.grey),
        //         )),
        //         Container(height: 30.0, width: 3.0, color: Colors.blue),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Expanded(
        //             flex: 4,
        //             child: Text(
        //               "${todaysWorkController.todayWork[i].description}",
        //               style: TextStyle(color: Colors.grey),
        //             ))
        //       ],
        //     ),
        //     smallSizedBox,
        //     Divider(),
        //   ],
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("inside widget");
    print(DateFormat("dd-MM-yy").format(_selectedDay));
    return CustomScaffold(
      child: Obx(() => todaysWorkController.isLoading == true
          ? Center(
              child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSizedBox(100.0),
                  nameText(),
                  smallSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dateText(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCalVisible == false
                                ? isCalVisible = true
                                : isCalVisible = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              AssetImages.calendar,
                              height: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  smallSizedBox,
                  divider,
                  mediumSizedBox,
                  calendarWidget(),
                  largeSizedBox,
                  // subjectButton(),
                  smallSizedBox,
                  smallSizedBox,
                  textwidget(),
                  smallSizedBox,
                ],
              ),
            )),
    );
  }
}
