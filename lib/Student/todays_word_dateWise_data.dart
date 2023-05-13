import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/assignmentController.dart';
import 'package:little_angels/Controller/todaysWorkController.dart';
import 'package:little_angels/Student/subjects.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/network_handler.dart';
import 'package:little_angels/utils/student/app_widget.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:table_calendar/table_calendar.dart';

class TodaysWorkDateWiseData extends StatefulWidget {
  final TodaysWorkController todaysWorkController;
  final DateTime date;

  const TodaysWorkDateWiseData(
      {Key? key, required this.todaysWorkController, required this.date})
      : super(key: key);

  @override
  State<TodaysWorkDateWiseData> createState() => _TodaysWorkDateWiseDataState();
}

class _TodaysWorkDateWiseDataState extends State<TodaysWorkDateWiseData> {
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  var isCalVisible = false;
  var todaysWorkController = Get.put(TodaysWorkController());
  NetworkHandler nr = NetworkHandler();

  //
  // DateTime _selectedDay = DateTime.now();
  // DateTime? _focusedDay = DateTime.now();

  // initState() {
  //   _init();
  //   super.initState();
  // }
  //
  //
  // _init() async {
  //   bool isConnected = await nr.checkConnectivity();
  //   print(isConnected);
  //   if (isConnected) {
  //     todaysWorkController.getStuTodaysWork();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(days: 1),
  //       behavior: SnackBarBehavior.floating,
  //       content: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(
  //             Icons.signal_wifi_off,
  //             color: Colors.white,
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.only(
  //                 left: 16.0,
  //               ),
  //               child: Text(
  //                 'No internet available',
  //                 textAlign: TextAlign.start,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       action: SnackBarAction(
  //           textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
  //       backgroundColor: Colors.grey,
  //     ));
  //   }
  // }

  //nameText() => Text(widget.name.toString(), style: titleTextStyle);
  nameText() => Container(
        child: Text("Today's Work", style: titleTextStyle),
        width: double.infinity,
        alignment: Alignment.center,
      );

  dateText() => Text(
        DateFormat('dd MMMM yyyy').format(DateTime.now()),
        style: textButtonTextStyle,
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
    print('DATA ${todaysWorkController.todayWork.length}');
    // print('DATA ${todaysWorkController.todayWork[1].description}');
    return Column(
      children: [
        for (var i = 0; i < widget.todaysWorkController.todayWork.length; i++)
          if (DateFormat("dd-MM-yy")
                  .format(widget.todaysWorkController.todayWork[i].workDate)
                  .compareTo(DateFormat("dd-MM-yy").format(widget.date)) ==
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

                  mediumSizedBox,
                  AppWidgets.elevatedButtonForCalender(
                      selectedDay: widget.date),
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
