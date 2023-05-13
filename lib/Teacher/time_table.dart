// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/Teacher/message.dart';
import 'package:little_angels/Teacher/profile.dart';
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

class TimeTable extends StatefulWidget {
  final String? id;
  final String? name;
  const TimeTable({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final List<Map<String, dynamic>> _events = [
    {'title':'Mathematics',
     'Subtitle':'Class:6'},
    {'title':'Science', 
    'Subtitle':'Class:6'},
    {'title':'History', 
    'Subtitle':'Class:6'},
  ];
  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon:const  Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.black,
            ),
            onPressed: () => AnimatedNavigation.pushReplacementAnimatedNavigation(
                context,const  TeacherHome()),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
               // bottomRight: Radius.circular(20)
                ),
            child: Container(
              decoration:const  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.time),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape:const  RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              //bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const  Text("Class Time Table",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 2.0,
                        decorationStyle: TextDecorationStyle.solid,
                     
                        ),
                  ),
                  FloatingActionButton(
                    onPressed: (){},
                    child:const  Icon(Icons.add),
                    backgroundColor: Colors.deepPurple,
                    mini: true,
                  )
                ],
              ),
              smallSizedBox,
             
              divider,
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          largeSizedBox,
                          Row(
                            children: [
                              Text(
                                DateFormat('dd-MMMM-yyyy').format(DateTime.now()),
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                DateFormat('(EEEE)').format(todayDate).toString(),
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          smallSizedBox,
                          Card(
                            color: Colors.grey[200],
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ListTile(
                                title:  Text(_events[index]['title']),
                                subtitle: Text(_events[index]['Subtitle']),
                                trailing: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    height: 25,
                                    width: 150,
                                    color: Colors.teal,
                                    child: Center(
                                      child: Text(
                                        DateFormat()
                                                .add_jm()
                                                .format(todayDate)
                                                .toString() +
                                            ' - ' +
                                            DateFormat()
                                                .add_jm()
                                                .format(todayDate)
                                                .toString(),
                                        style:
                                            const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Divider(thickness: 2),
                              itemCount: 3,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
