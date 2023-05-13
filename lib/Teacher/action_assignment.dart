// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class ActionAssignment extends StatefulWidget {
  const ActionAssignment({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionAssignment> createState() => _ActionAssignmentState();
}

class _ActionAssignmentState extends State<ActionAssignment> {
  TextEditingController _marksController = TextEditingController();
  TextEditingController _feedbackController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
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
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 160,
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.detail),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(55, 61, 99, 1.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                //bottomRight: Radius.circular(40),
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            children: [
           const  Center(
               child: Text(
                  "View Submission Details",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
             ),
              const Divider(color: Colors.grey),
              smallSizedBox,
              const Text(
                "Uplaoded Documents",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              largeSizedBox,
              Container(
                color: Colors.green[300],
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  AssetImages.profile,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              largeSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Marks",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      size: 8,
                      color: Colors.red,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              TextField(
                  controller: _marksController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    hintText: ("8"),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    isDense: true,
                  )),
              largeSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Select Status",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      size: 8,
                      color: Colors.red,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              TextField(
                  controller: _marksController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    hintText: ("Accept"),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    isDense: true,
                  )),
              largeSizedBox,
              Row(
                children: [
                  const Text(
                    "Remarks",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    size: 8,
                    color: Colors.red,
                  )
                ],
              ),
              smallSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.yellow[600],
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.yellow[600],
                  ),
                  const Icon(
                    Icons.star,
                    size: 25,
                    color: Colors.grey,
                  ),
                ],
              ),
              largeSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Descriptions:",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      size: 8,
                      color: Colors.red,
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              TextField(
                  controller: _feedbackController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  cursorWidth: 2.0,
                  // textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    hintText: "Test",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    //isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  )),
                  largeSizedBox,
                  largeSizedBox,
            ],
          )),
    );
  }
}
