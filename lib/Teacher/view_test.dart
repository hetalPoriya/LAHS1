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

class ViewTest extends StatefulWidget {
  final String? id;
  final String? name;
  const ViewTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<ViewTest> createState() => _ViewTestState();
}

class _ViewTestState extends State<ViewTest> {
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
            onPressed: () =>  Navigator.of(context).pop(),
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
                  image: AssetImage(AssetImages.result1),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("View Test", style: titleTextStyle)),
                  smallSizedBox,
                  // Text(
                  //   DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  //   style: textButtonTextStyle,
                  // ),
                  divider,
                  smallSizedBox,
                  Row(
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
                 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        color: ColorConstants.kGreyColor100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                               // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "S no.:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 1"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Question:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(width: 5,),
                                      GestureDetector(
                                        onTap: (){},
                                        child: SvgPicture.asset(
                                          AssetImages.drawerAssignment,
                                          color: Colors.pink,
                                          height: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Option:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 1"),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        "Option:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 2"),
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        "Option:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 3"),
                                      const Icon(Icons.check,
                                      color: Colors.pink,
                                      size: 20,)
                                    ],
                                  ),
                                   Row(
                                    children: [
                                      const Text(
                                        "Option:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 4"),
                                    ],
                                  ),
                                ],
                              ),
                              //const SizedBox(height: 30),
                              Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "Answer:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Option:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const Text(" 3"),
                                     
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
