// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/subjects.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsActivity extends StatefulWidget {
  final String? id;
  final String? name;
  const EventsActivity({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<EventsActivity> createState() => _EventsActivityState();
}

class _EventsActivityState extends State<EventsActivity> {
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');

  nameText() => Text("Events & Activities".toUpperCase(), style: titleTextStyle);

  dateText() => Text(
        DateFormat('dd-MM-yyyy').format(DateTime.now()),
        style: textButtonTextStyle,
      );

  calendarWidget() => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
          left: BorderSide(color: Colors.grey, width: 1),
          bottom: BorderSide(color: Colors.grey, width: 1),
          right: BorderSide(color: Colors.grey, width: 1),
        ),
       
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
        child: TableCalendar(
          rowHeight: 25.0,
          headerVisible: true,
          daysOfWeekHeight: 80.0,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          headerStyle: const HeaderStyle(
            headerPadding: EdgeInsets.symmetric(horizontal: 20),
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle:
                  TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
              weekendStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
          calendarStyle: const CalendarStyle(
              markerSizeScale: 1.3,
              todayDecoration: BoxDecoration(
                  color: ColorConstants.kHeadingTextColor,
                  shape: BoxShape.circle),
              todayTextStyle:
                  TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
              selectedTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
              outsideTextStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              weekendTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
              defaultTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
          firstDay: DateTime.utc(1999, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: ColorConstants.kBlackColor),
                ),
              );
            },
            todayBuilder: (context, date, _) {
              return Container(
                // margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: ColorConstants.kHeadingTextColor,
                    borderRadius: BorderRadius.circular(50.0)),
                // width: 100,
                // height: 100,
                child: Text(
                  '${date.day}',
                  style: const TextStyle(
                      color: ColorConstants.kWhiteColor, fontSize: 12.0),
                ),
              );
            },
          ),
        ),
      ));

  calendarContainerWidget() => Container(
      height: MediaQuery.of(context).size.height / 2.4,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: Colors.black26)),
      child: calendarWidget()
      // Row(
      //   children: [calendarTextWidget(), calendarWidget()],
      // ),
      );
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
            Text(DateFormat('EEEE').format(todayDate).toString()),
            Text(DateFormat('dd MMM yyyy').format(todayDate).toString()),
          ],
        ),
      );

  timewidget() => Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(DateFormat().add_jm().format(todayDate).toString()),
                Text(DateFormat().add_jm().format(todayDate).toString()),
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
              flex: 4, child: Text("Regular School Timings for New Students"))
        ],
      );

  textwidget() => Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Expanded(child: Text("All day")),
          Container(height: 30.0, width: 3.0, color: Colors.blue),
          const SizedBox(
            width: 5,
          ),
          const Expanded(flex: 4, child: Text("Health day celebration"))
        ],
      );
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(100.0),
            nameText(),
            smallSizedBox,
            dateText(),
            smallSizedBox,
            divider,
            mediumSizedBox,
            calendarWidget(),
            largeSizedBox,
            subjectButton(),
            smallSizedBox,
            timewidget(),
            smallSizedBox,
            divider,
            smallSizedBox,
            textwidget(),
            smallSizedBox,
            divider,
            smallSizedBox,
          ],
        ),
      ),
    );
  }
}
