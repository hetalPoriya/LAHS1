// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/TeacherNewMsgController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Student/subjects.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/Teacher/message.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

import '../utils/network_handler.dart';

class TeacherNewMessage extends StatefulWidget {
  const TeacherNewMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherNewMessage> createState() => _TeacherNewMessageState();
}

class _TeacherNewMessageState extends State<TeacherNewMessage> {
  String? selectedValue;
  List<String> items = [
    'I',
    'II',
    'III',
  ];
  String? selectedValue1;
  List<String> section = [
    'A',
    'B',
    'C',
  ];
  String? selectedValue2;
  List<String> student = [
    'Amar',
    'Select Student',
  ];

  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  DateTime todayDate = DateTime.now();

  var newMsgController = Get.put(TeacherNewMsgController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      newMsgController.studentVisible(false);
      newMsgController.getClassesSections();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(

          // backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: IconButton(
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 150,
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
                //bottomRight: Radius.circular(20),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.compose),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                // bottomRight: Radius.circular(40),
              ),
            ),
          ),
          body: Obx(() => newMsgController.isLoading == true
              ? Center(
                  child: Image.asset(
                    "assets/loading.gif",
                    height: 425.0,
                    width: 425.0,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 20, left: 15, right: 15),
                  children: [
                    const Text(
                      "Compose New\n Message",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    smallSizedBox,
                    const Divider(color: Colors.grey),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 5),
                      child: const Text(
                        "Class:",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                              'Select Class',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).hintColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          items: [
                            for (var i in newMsgController.classesSections)
                              DropdownMenuItem<String>(
                                value: i.classId.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    i.className,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                          value: selectedValue,
                          onChanged: (String? value) {
                            newMsgController.classId(int.parse(value!));
                            setState(() {
                              selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 5, top: 6),
                      child: const Text(
                        "Section:",
                        style: TextStyle(
                          fontSize: 15,
                        ),
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
                              'Select Section',
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).hintColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          items: [
                            for (var i in newMsgController.classesSections)
                              DropdownMenuItem<String>(
                                value: i.sectionId.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    i.sectionName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                          value: selectedValue1,
                          onChanged: (String? value) async {
                            newMsgController.sectionId(int.parse(value!));
                            await newMsgController.getStudentsByClassSection();
                            setState(() {
                              selectedValue1 = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: newMsgController.studentVisible.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 6, bottom: 5),
                              child: const Text(
                                "Student:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                      'Select Student',
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Theme.of(context).hintColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  items: [
                                    for (var i in newMsgController.students)
                                      DropdownMenuItem<String>(
                                        value: i.studentId.toString(),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            i.studentName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                  value: selectedValue2,
                                  onChanged: (String? value) {
                                    newMsgController
                                        .studentId(int.parse(value!));
                                    setState(() {
                                      selectedValue2 = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 6, bottom: 5),
                      child: const Text(
                        "Title:",
                        //textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        ),
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
                        controller: newMsgController.title,
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 6, right: 5, bottom: 5),
                      child: const Text(
                        "Message:",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                          controller: newMsgController.message,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          cursorWidth: 2.0,
                          decoration: const InputDecoration(
                            hintText: "Message",
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                          )),
                    ),
                    largeSizedBox,
                    smallSizedBox,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    const Text(
                                      "Discard",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  primary:
                                      const Color.fromRGBO(105, 80, 255, 1.0),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                bool isConnected = await nr.checkConnectivity();
                                if (isConnected) {
                                  await newMsgController.teacherSendMessage();
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(newMsgController
                                                .status.value)));
                                    Get.off(TeacherMessage());
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: Duration(days: 1),
                                    behavior: SnackBarBehavior.floating,
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.signal_wifi_off,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              'No internet available',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: 'RETRY',
                                        onPressed: () async {}),
                                    backgroundColor: Colors.grey,
                                  ));
                                }
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.message_rounded,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  const Text(
                                    "Send Message",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Visibility(
                                      visible: newMsgController.isMsgSent.value,
                                      child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                primary:
                                    const Color.fromRGBO(105, 80, 255, 1.0),
                              ),
                            ),
                            //SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    largeSizedBox,
                  ],
                ))),
    );
  }
}
