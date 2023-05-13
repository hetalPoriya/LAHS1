// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/dailyActivityController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class ActivityDetails extends StatefulWidget {
  final int? id;
  final String? from;
  ActivityDetails({
    Key? key,
    required this.id,
    required this.from,
  }) : super(key: key);

  @override
  State<ActivityDetails> createState() => _ActivityDetailsState();
}

class _ActivityDetailsState extends State<ActivityDetails> {
  DateTime todayDate = DateTime.now();
  var dailyActivityController = Get.put(DailyActivityController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          "Activities",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        child: widget.from == "sports_activities"?ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 10),
              dense: true,
              isThreeLine: false,
              leading: SvgPicture.asset(
                AssetImages.drawerMyProfile,
                color: Colors.black,
                height: 30,
              ),
              title: Text(
                dailyActivityController.sport_activities[widget.id!].teacherName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              subtitle: Text(
                dailyActivityController.sport_activities[widget.id!].activitySubject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            const Divider(color: Colors.grey),
            /*Row(
              children: [
                const Text(
                  "Good Luck!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(width: 150),
                Image.network(
                  dailyActivityController.sport_activities[widget.id!].activityImage,
                  width: 50,
                  height: 50,
                ),
              ],
            ),*/
            largeSizedBox,
            Text(
              "Title: ${dailyActivityController.sport_activities[widget.id!].activityTitle}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              "${dailyActivityController.sport_activities[widget.id!].activityDescription}",
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
          ],
        ):
        ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 10),
              dense: true,
              isThreeLine: false,
              leading: SvgPicture.asset(
                AssetImages.drawerMyProfile,
                color: Colors.black,
                height: 30,
              ),
              title: Text(
                dailyActivityController.other_activities[widget.id!].teacherName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              subtitle: Text(
                dailyActivityController.other_activities[widget.id!].activitySubject,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            const Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dailyActivityController.other_activities[widget.id!].activityTitle,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Image.network(
                  dailyActivityController.other_activities[widget.id!].activityImage,
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            largeSizedBox,
            Text(
              "${dailyActivityController.other_activities[widget.id!].activityDescription}",
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
          ],
        )
    );
  }
}
