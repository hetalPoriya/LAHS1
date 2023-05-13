// // ignore_for_file: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class TeacherEvents extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherEvents({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherEvents> createState() => _TeacherEventsState();
}

class _TeacherEventsState extends State<TeacherEvents> {
  final List<Map<String, dynamic>> _eventslist = [
    {'title': 'Surfing', 'icon': AssetImages.surfing, 'Description': 'Surfing'},
    {'title': 'Runnig', 'icon': AssetImages.running, 'Description': 'Running'},
    {'title': 'Chess', 'icon': AssetImages.chess, 'Description': 'Chess'},
    {'title': 'Music', 'icon': AssetImages.music, 'Description': 'Music'},
    {'title': 'Karate', 'icon': AssetImages.karatae, 'Description': 'Karate'},
  ];
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
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
                  image: AssetImage(AssetImages.activity2),
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
              Center(
                child: Text(
                  "Events List",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2.0,
                    decorationStyle: TextDecorationStyle.solid,
                    // wordSpacing: 8,
                    //letterSpacing: 2,
                    // ignore: prefer_const_literals_to_create_immutables
                    // shadows: [
                    //   Shadow(
                    //       color: Colors.black,
                    //       blurRadius: 2.0,
                    //       offset: Offset(3, 1))
                    // ]
                  ),
                ),
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
                                   //width: 120.0,
                                  height: 79.0,
                                ),
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _eventslist[index]['title'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  smallSizedBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        "Date",
                                        style: TextStyle(color: Colors.grey,fontSize: 13),
                                      ),
                                      const SizedBox(width: 87),
                                      Text(
                                        "Time",
                                        style: TextStyle(color: Colors.grey,fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  smallSizedBox,
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat('MMM dd,yyyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(color: Colors.teal,fontSize: 13,
                                       // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                       const SizedBox(width: 41),
                                     Text( DateFormat().add_jm().format(todayDate).toString(),
                                      style: TextStyle(color: Colors.teal,
                                            fontSize: 13,
                                           // fontWeight: FontWeight.bold
                                            ),
                                     ),
                                    ],
                                  ),
                                  smallSizedBox,
                                  Row(
                                    children: [
                                      Text("Description: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(
                                        _eventslist[index]['Description'],
                                      
                                      ),
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
