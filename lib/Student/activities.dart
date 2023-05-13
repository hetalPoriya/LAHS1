// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/dailyActivityController.dart';
import 'package:little_angels/Student/activity_details.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class Activity extends StatefulWidget {
  final String? id;
  final String? name;
  final double? elevation;
  final String? title;
  const Activity({
    Key? key,
    this.id,
    this.name,
    this.elevation,
    required this.title,
  }) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  var dailyActivityController = Get.put(DailyActivityController());
  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: ListView(children: [
        const Text(
          "Activities",
          style: TextStyle(
              color: Color.fromARGB(255, 145, 92, 236),
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        const SizedBox(height: 5),
        Text(
          DateFormat('dd MMMM yyyy').format(DateTime.now()),
          style: textButtonTextStyle,
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.grey,
        ),
        Obx(() => widget.id == '1'?ListView.builder(
            shrinkWrap: true,
            itemCount: dailyActivityController.sport_activities.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                // contentPadding: EdgeInsets.only(left:10),
                // minLeadingWidth: 10,
                dense: false,
                leading: Image.network(dailyActivityController.sport_activities[index].activityImage,),
                title: Text(
                  dailyActivityController.sport_activities[index].activityTitle,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  dailyActivityController.sport_activities[index].activitySubject
                    ),
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context,
                    ActivityDetails(
                      id: index,
                      from: "sports_activities",
                    )),
                // onLongPress: () {},
                isThreeLine: true,
              ),
            ),):
        ListView.builder(
          shrinkWrap: true,
          itemCount: dailyActivityController.other_activities.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              // contentPadding: EdgeInsets.only(left:10),
              // minLeadingWidth: 10,
              dense: false,
              leading: Image.network(dailyActivityController.other_activities[index].activityImage),
              title: Text(
                dailyActivityController.other_activities[index].activityTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  dailyActivityController.other_activities[index].activitySubject),
              onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                  context,
                  ActivityDetails(
                id: index,
                    from: "other_activities",
                  )),
              // onLongPress: () {},
              isThreeLine: true,
            ),
          ),)
        ),
      ]),
    );
  }
}
//  return CustomScaffold(
//       showAppBar: true,
//       showDrawer: false,
//       automaticallyImplyLeading: true,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              ],
//         ),
//       ),
//     );
//   }
// }