// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/activities.dart';
import 'package:little_angels/Student/assignments.dart';
import 'package:little_angels/Student/attendance.dart';
import 'package:little_angels/Student/activity_details.dart';
import 'package:little_angels/Student/message.dart';
import 'package:little_angels/Student/my_profile.dart';
import 'package:little_angels/Student/notification.dart';
import 'package:little_angels/Student/video.dart';
import 'package:little_angels/Student/view_events.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/todays_work.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/Teacher/profile.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_drawer.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class TeacherProfile extends StatefulWidget {
  TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  String? selectedValue;
  List<String> items = [
    'Male',
    'Female',
    'Others',
  ];
  TextEditingController _branchnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _teachertypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              decorationThickness: 2.0,
              decorationStyle: TextDecorationStyle.solid,
              wordSpacing: 10,
              letterSpacing: 2,
              shadows: [
                Shadow(
                    color: Colors.black, blurRadius: 2.0, offset: Offset(3, 1))
              ]),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                CustomPaint(
                  child: Container(
                    height: 150,
                    // width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AssetImages.log),
                          //  NetworkImage(
                          //   'https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png',
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          smallSizedBox,
          Expanded(
            child: SingleChildScrollView(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Column(
                  children: [
                    const Text(
                      "Er Amar",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                          decorationThickness: 2.0,
                          decorationStyle: TextDecorationStyle.solid,
                          wordSpacing: 8,
                          shadows: [
                            Shadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                offset: Offset(3, 1))
                          ]),
                    ),

                    largeSizedBox,
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Contact:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "1234567890",
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Email:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "amar@synram.co",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    largeSizedBox,
                    smallSizedBox,

                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Name:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: "Enter Name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),

                    // Container(
                    //   child: TextField(
                    //       controller: _nameController,
                    //       decoration: const InputDecoration(
                    //         filled: true,
                    //         fillColor:Color.fromARGB(255, 250, 244, 252),
                    //         contentPadding:
                    //             EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    //         hintText: ("Er Amar"),
                    //        focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    //         ),

                    //         isDense: true,
                    //       )),
                    // ),

                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Branch Name:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _branchnameController,
                        decoration: const InputDecoration(
                          hintText: "City Name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),

                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Class:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _classController,
                        decoration: const InputDecoration(
                          hintText: "I",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Section:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _sectionController,
                        decoration: const InputDecoration(
                          hintText: "A",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Gender:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          //  border: InputBorder.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton(
                          focusColor: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          isDense: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Select Gender',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).hintColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Contact:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _contactController,
                        decoration: const InputDecoration(
                          hintText: "1234567890",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),

                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Teacher Type:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _teachertypeController,
                        decoration: const InputDecoration(
                          hintText: "Activity type",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),

                    largeSizedBox,
                    largeSizedBox,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 12),
                            ),
                            onPressed: () {
                              log(_emailController.text);
                              log(_nameController.text);
                              log(_branchnameController.text);
                              log(_classController.text);
                              log(_sectionController.text);
                              log(_contactController.text);
                              log(_teachertypeController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              primary: const Color.fromRGBO(105, 80, 255, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    largeSizedBox,
                    largeSizedBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.deepPurple;
    Path path = Path()
      ..relativeLineTo(0, 80)
      ..quadraticBezierTo(size.width / 2, 150, size.width, 80)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
