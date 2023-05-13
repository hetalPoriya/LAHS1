// ignore_for_file: unused_import

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

class ChangeRequest extends StatefulWidget {
  const ChangeRequest({
    Key? key,
  }) : super(key: key);
  @override
  State<ChangeRequest> createState() => _ChangeRequestState();
}

class _ChangeRequestState extends State< ChangeRequest> {
  String? selectedValue;
  List<String> items = [
    'Male',
    'Female',
    'Others',
  ];
  TextEditingController _requestController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  TextEditingController _relativeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Change Request",
                style: titleTextStyle,
              ),
              Text(
                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
             divider,
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Request ID",
                  //textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              Container(
                child: TextField(
                    controller: _requestController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                     hintText: ("Student Name"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              // const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Detail change request"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
             
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Relation Type",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _relationController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    hintText: (" Enter Relation Type"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Relative Name",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _relativeController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                     hintText: ("Enter Relative Name"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),
             
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Change Description",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  cursorWidth: 2.0,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(),
                    //isDense: true,
                  )),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "E-mail Address",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Email"),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),

              
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Father Contact No.",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              Container(
                child: TextField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      hintText: ("Mobile No."),
                      border: OutlineInputBorder(),
                      isDense: true,
                    )),
              ),

              const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    child: const Text(
                      "Submit Request",
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      log(_emailController.text);
                      log(_requestController.text);
                      log(_relationController.text);
                      log(_relativeController.text);
                      log(_descriptionController.text);
                      log(_mobileController.text);
                      log(_titleController.text);
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
            ]),
          ),
        ));
  }
}
