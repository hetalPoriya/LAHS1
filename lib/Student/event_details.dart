// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/calEventController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class EventDetails extends StatefulWidget {
  final int? id;
  EventDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  DateTime todayDate = DateTime.now();
  var calEventController = Get.put(CalEventController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          "Events",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        child:
        ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            largeSizedBox,
            const Divider(color: Colors.grey),
            largeSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  calEventController.calender_events[widget.id!].eventTitle,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            smallerSizedBox,
            Text(
              DateFormat('dd MMMM yyyy').format(calEventController.calender_events[widget.id!].eventDate),
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,),
            ),
            largeSizedBox,
            Text(
              "${calEventController.calender_events[widget.id!].eventDescription}",
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
          ],
        )
    );
  }
}
