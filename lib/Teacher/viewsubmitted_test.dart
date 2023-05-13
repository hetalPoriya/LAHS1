// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/upload_video.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/video_player.dart';

class ViewSubmittedTest extends StatefulWidget {
  final String? id;
  final String? name;
  const ViewSubmittedTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<ViewSubmittedTest> createState() => _ViewSubmittedTestState();
}

class _ViewSubmittedTestState extends State< ViewSubmittedTest > {
  DateTime todayDate = DateTime.now();

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
            onPressed: () => Navigator.of(context).pop(),
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
                  image: AssetImage(AssetImages.submit),
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
          padding: const EdgeInsets.only(top: 20 ,left: 14,right: 10),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("View Submitted Test", style: titleTextStyle)),
                smallSizedBox,
               
                divider,
                smallSizedBox,
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Test Name:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Test 1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                  
                  Row(
                    children: [
                      Text(
                        "Class:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "I",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Subject:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Python",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Valid till:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  largeSizedBox,
                               const Text("Q.1 Python Test question"),
                               smallSizedBox,
                   Padding(
                     padding: const EdgeInsets.only(right: 240),
                     child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AssetImages.drawerAssignment,
                        color: Colors.blue,
                        height: 50,
                      ),
                  ),
                   ),
                  largeSizedBox,
                  Row(
                    children: [
                      Icon(Icons.check,
                      size: 20,
                      color: Colors.green,),
                      const Text("Correct answer:",
                      style: TextStyle(color: Colors.green)),
                      const Text(" Option 3"),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){},
                        child: SvgPicture.asset(
                          AssetImages.drawerAssignment,
                          color: Colors.blue,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                              largeSizedBox,
                   Row(
                    children: [
                      Icon(
                        Icons.cancel_rounded,
                        size: 20,
                        color: Colors.red,
                      ),
                      const Text("Submitted answer:",
                          style: TextStyle(color: Colors.red)),
                      const Text(" Option 4"),
                      const SizedBox(
                        width: 5,
                      ),
                      
                    ],
                  ),
                  largeSizedBox,
                 
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: Color.fromARGB(255, 43, 70, 92),
                      child:Column(
                        children: [
                          const Text(
                            "Test Feedback:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                                decorationStyle: TextDecorationStyle.solid,
                                wordSpacing: 10,
                                shadows: [
                    Shadow(
                            color: Colors.black, blurRadius: 2.0, offset: Offset(3, 1))
                                ]),
                          ),
                          smallSizedBox,
                          const Text(
                            "Your Submitted answer\n is wrong the correct\n answer is option:3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                                decorationStyle: TextDecorationStyle.solid,
                                wordSpacing: 10,
                                shadows: [
                    Shadow(
                        color: Colors.black, blurRadius: 2.0, offset: Offset(3, 1))
                                ]),
                          ),
                  
                        ],
                      ),
                    ),
                  ),
                  largeSizedBox,
                              ],
                            ),
                ),
         ] ),
         ),
        ),
      ),
    );
  }
}
