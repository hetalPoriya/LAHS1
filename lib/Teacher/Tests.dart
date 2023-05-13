// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter

//import 'dart:js';

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/add_test.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/Teacher/submission_test.dart';
import 'package:little_angels/Teacher/upload_video.dart';
import 'package:little_angels/Teacher/view_test.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/video_player.dart';

class TeacherTest extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherTest> createState() => _TeacherTestState();
}

class _TeacherTestState extends State<TeacherTest> {
  DateTime todayDate = DateTime.now();
  final List<Map<String, dynamic>> _eventslist = [
    {
      'title': 'Test 1',
      'subject': 'Python',
      'icon': AssetImages.python1,
      'Description': 'Surfing'
    },
    {
      'title': 'Test 2',
      'subject': 'PHP',
      'icon': AssetImages.php1,
      'Description': 'Running'
    },
    {
      'title': 'Test 3',
      'subject': 'Java',
      'icon': AssetImages.java,
      'Description': 'Chess'
    },
    {
      'title': 'Test 4',
      'subject': 'Web Tech',
      'icon': AssetImages.web,
      'Description': 'Music'
    },
  ];

  get betterPlayerConfiguration => null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () =>
                AnimatedNavigation.pushReplacementAnimatedNavigation(
                    context, const TeacherHome()),
          ),
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.add),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tests",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      decorationThickness: 2.0,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => AnimatedNavigation.pushAnimatedNavigation(
                        context, AddTest()),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: Colors.deepPurple,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        Text(
                          "Add Test",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              divider,
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _eventslist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  _eventslist[index]['icon'],
                                  // width: 110.0,
                                  height: 60.0,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Test Name:  ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _eventslist[index]['title'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  smallSizedBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Subject",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                          ),
                                        smallSizedBox,
                                          Text(
                                            _eventslist[index]['subject'],
                                            style: const TextStyle(
                                              color: Colors.teal,
                                              fontSize: 13,
                                              //fontWeight: FontWeight.bold
                                            ),
                                          ),
                                         
                                        ],
                                      ),
                                  
                                 SizedBox(width:40),
                                  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                            "Expire at",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                          smallSizedBox,
                                      Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                          color: Colors.teal, fontSize: 13,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                    ],
                                  ),
                                  smallSizedBox,
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => AnimatedNavigation
                                              .pushAnimatedNavigation(
                                                  context, ViewTest()),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.deepPurple,
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3)),
                                          child: Text("View Questions",
                                              style: TextStyle(fontSize: 10))),
                                      const SizedBox(width: 5),
                                      ElevatedButton(
                                          onPressed: () => AnimatedNavigation
                                              .pushAnimatedNavigation(
                                                  context, SubmissionTest()),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              padding: EdgeInsets.only(
                                                  left: 3, right: 3)),
                                          child: Text("View Submissions",
                                              style: TextStyle(fontSize: 10))),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
