// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/uploadVideoController.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/video.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:multiselect/multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../utils/network_handler.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  String? selectedValue;
  List<String> items = [
    'I',
    'II',
    'III',
  ];
  String? selectedValue1;
  List<String> multiSelectedValue = [];
  List<String> subject = [
    'Php',
    'Python',
    'Java',
  ];
  String? selectedValue2;
  List<String> student = [
    'Amar',
    'Select Student',
  ];
  List? _myStudents;

  TextEditingController _urlController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime todayDate = DateTime.now();
  var uploadVideoController = Get.put(UploadVideoController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();
    _myStudents = [];
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();
    print(isConnected);
    if (isConnected) {
      uploadVideoController.isSubjectVisible(false);
      uploadVideoController.getClass();
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
            toolbarHeight: 150,
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(90),
                //bottomRight: Radius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.upload),
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
          body: Obx(() => uploadVideoController.isLoading == true
              ? Center(
                  child: Image.asset(
                    "assets/loading.gif",
                    height: 425.0,
                    width: 425.0,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  children: [
                    const Center(
                      child: Text(
                        "Upload Video",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    smallSizedBox,
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 6, bottom: 5),
                      child: const Text(
                        "Class:",
                        //textAlign: TextAlign.end,
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
                            for (var i in uploadVideoController.classes)
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
                          onChanged: (String? value) async {
                            uploadVideoController.classId(int.parse(value!));
                            await uploadVideoController.getSubjectStudent();
                            setState(() {
                              print(value);
                              selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Visibility(
                      visible: uploadVideoController.isSubjectVisible.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 5, top: 6),
                            child: const Text(
                              "Subjects:",
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
                                    'Select Subjects',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                items: [
                                  for (var i in uploadVideoController.subjects)
                                    DropdownMenuItem<String>(
                                      value: i.subjectId.toString(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Text(
                                          i.subjectName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                                value: selectedValue1,
                                onChanged: (String? value) {
                                  setState(() {
                                    uploadVideoController
                                        .subjectId(int.parse(value!));
                                    selectedValue1 = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 6, bottom: 5),
                      child: const Text(
                        "Video URL:",
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
                        controller: uploadVideoController.videoUrlController,
                        decoration: const InputDecoration(
                          hintText: "Enter URL",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15.0),
                        ),
                      ),
                    ),
                    smallSizedBox,
                    Visibility(
                        visible: uploadVideoController.isSubjectVisible.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0),
                              child: MultiSelectFormField(
                                autovalidate: AutovalidateMode.disabled,
                                chipBackGroundColor: Colors.blue,
                                chipLabelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                dialogTextStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                checkBoxActiveColor: Colors.blue,
                                checkBoxCheckColor: Colors.white,
                                dialogShapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                title: Text(
                                  "Students",
                                  style: TextStyle(fontSize: 16),
                                ),
                                validator: (value) {
                                  if (value == null || value.length == 0) {
                                    return 'Please select one or more students';
                                  }
                                  return null;
                                },
                                dataSource: [
                                  for (var i in uploadVideoController.students)
                                    {
                                      "display": "${i.studentName}",
                                      "value": "${i.studentId}",
                                    },
                                ],
                                textField: 'display',
                                valueField: 'value',
                                okButtonLabel: 'OK',
                                cancelButtonLabel: 'CANCEL',
                                hintWidget: Text('Please choose one or more'),
                                initialValue: _myStudents,
                                onSaved: (value) {
                                  print(value);
                                  if (value == null) return;
                                  uploadVideoController.studentId(value);
                                  setState(() {
                                    _myStudents = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    smallSizedBox,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 6, bottom: 5),
                      child: const Text(
                        "Descriptions:",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                          controller: uploadVideoController.videoDescController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          cursorWidth: 2.0,
                          // textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            hintText: "Description",
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            //isDense: true,
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
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                bool isConnected = await nr.checkConnectivity();
                                if (isConnected) {
                                  await uploadVideoController.uploadVideo();
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(uploadVideoController
                                                .status.value)));
                                    Get.off(const TeacherVideo(
                                      name: "Video",
                                    ));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Submit",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Visibility(
                                        visible: uploadVideoController
                                            .isUploadLoading.value,
                                        child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ))),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ]),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                primary:
                                    const Color.fromRGBO(105, 80, 255, 1.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    const Text(
                                      "Close",
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
                            largeSizedBox,
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
    );
  }
}
