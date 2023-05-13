// ignore_for_file: unused_import, prefer_const_constructors, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Controller/teacherMarkAttendanceController.dart';
import 'package:little_angels/Student/assignments_inbox.dart';
import 'package:little_angels/Student/events_activity.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/action_assignment.dart';
import 'package:little_angels/Teacher/create_assignment.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/Teacher/view_attendance.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_drop_down.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../utils/network_handler.dart';

class TeacherAttendance extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherAttendance({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherAttendance> createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  DateTime todayDate = DateTime.now();
  late DateTime _dateTime;
  String? markselectedValue1;
  String? markselectedValue2;
  String? markselectedValue3;
  String? dayselectedValue1;
  String? dayselectedValue2;
  String? dayselectedValue3;
  String? stuselectedValue1;
  String? stuselectedValue2;
  String? stuselectedValue3;
  String? stuselectedValue4;
  List? _myStudents;
  var teacherMarkAttendanceController =
      Get.put(TeacherMarkAttendanceController());
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
      teacherMarkAttendanceController.studentVisible(false);
      teacherMarkAttendanceController.viewAttendance(false);
      teacherMarkAttendanceController.getClassesSections();
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
      child: DefaultTabController(
          length: 1,
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
                      image: AssetImage(AssetImages.mark),
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
                      "Mark Attendance",
                      style: titleTextStyle,
                    ),
                  ),
                  divider,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(
                            text: "Mark Attendance",
                          ),
                        ],
                        isScrollable: true,
                        labelColor: ColorConstants.kBlackColor,
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        unselectedLabelColor: ColorConstants.kBlackColor,
                      ),
                      InkWell(
                        onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                            context, TeacherViewAttendance()),
                        child: Row(
                          children: const [
                            Icon(Icons.remove_red_eye,
                                color: ColorConstants.kHeadingTextColor),
                            SizedBox(width: 5),
                            Text("View Attendance")
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildTabBarView(context),
                ],
              ),
            ),
          )),
    );
  }

  buildTabBarView(context) {
    return Obx(() => teacherMarkAttendanceController.isLoading == true
        ? Center(
            child: Image.asset(
            "assets/loading.gif",
            height: 425.0,
            width: 425.0,
            fit: BoxFit.fitHeight,
          ))
        : Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: TabBarView(
                key: ValueKey(DateTime.now().toString()),
                physics: const ScrollPhysics(),
                children: [
                  ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Class:",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          smallSizedBox,
                          DropdownButtonFormField(
                            items: [
                              for (var i in teacherMarkAttendanceController
                                  .classesSections)
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
                            hint: Text("Select Class"),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorConstants.kBlackColor,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            dropdownColor: Colors.white,
                            value: markselectedValue1,
                            onChanged: (String? value) {
                              teacherMarkAttendanceController
                                  .classId(int.parse(value!));
                              setState(() {
                                markselectedValue1 = value;
                              });
                            },
                          ),
                          smallSizedBox,
                          const Text(
                            "Section:",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          smallSizedBox,
                          CustomDropDown(
                            hintText: "Select Section",
                            items: [
                              for (var i in teacherMarkAttendanceController
                                  .classesSections)
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
                            selectedValue: markselectedValue2,
                            onChanged: (value) async {
                              teacherMarkAttendanceController
                                  .sectionId(int.parse(value!));
                              await teacherMarkAttendanceController
                                  .getStudentsByClassSection();
                              setState(() {
                                markselectedValue2 = value!;
                              });
                            },
                          ),
                          smallSizedBox,
                          Visibility(
                              visible: teacherMarkAttendanceController
                                  .studentVisible.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, top: 0),
                                    child: MultiSelectFormField(
                                      autovalidate: AutovalidateMode.disabled,
                                      chipBackGroundColor: Colors.blue,
                                      chipLabelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      dialogTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                        if (value == null ||
                                            value.length == 0) {
                                          return 'Please select one or more students';
                                        }
                                        return null;
                                      },
                                      dataSource: [
                                        for (var i
                                            in teacherMarkAttendanceController
                                                .students)
                                          {
                                            "display": "${i.studentName}",
                                            "value": "${i.studentId}",
                                          },
                                      ],
                                      textField: 'display',
                                      valueField: 'value',
                                      okButtonLabel: 'OK',
                                      cancelButtonLabel: 'CANCEL',
                                      hintWidget:
                                          Text('Please choose one or more'),
                                      initialValue: _myStudents,
                                      onSaved: (value) {
                                        print(value);
                                        if (value == null) return;
                                        teacherMarkAttendanceController
                                            .studentId(value);
                                        setState(() {
                                          _myStudents = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          smallSizedBox,
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "Date of Attendance",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 3),
                          ),
                          TextField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1999),
                                  lastDate: DateTime(2040),
                                ).then((date) {
                                  teacherMarkAttendanceController
                                          .attendanceDate.text =
                                      DateFormat('dd-MM-yyyy').format(date!);
                                  setState(() {
                                    _dateTime = date;
                                  });
                                });
                              },
                              controller: teacherMarkAttendanceController
                                  .attendanceDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1999),
                                        lastDate: DateTime(2040),
                                      ).then((date) {
                                        teacherMarkAttendanceController
                                                .attendanceDate.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(date!);
                                        setState(() {
                                          _dateTime = date;
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.calendar_month)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                //  hintText: (_dateTime==null ? 'nothing':_dateTime.toString()),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                isDense: true,
                              )),
                          /*Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: SingleChildScrollView(
                        child: DataTable(columnSpacing: 13,
                            //horizontalMargin: 20,
                            columns: [
                              DataColumn(
                                label: Text('Sno.'),
                              ),
                              DataColumn(
                                label: Text('ID'),
                              ),
                              DataColumn(
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Email'),
                              ),
                              DataColumn(
                                label: Text('Action'),
                              ),
                            ], rows: [
                          DataRow(cells: [
                            DataCell(Text('1')),
                            DataCell(Text('###')),
                            DataCell(Text('Amar')),
                            DataCell(Text('abc@gmail.com')),
                            DataCell(Text('present')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                          ])
                        ]),
                      ),
                    ),*/
                          mediumSizedBox,
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                teacherMarkAttendanceController
                                    .teacherMarkAttendance();
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 12),
                              ),
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
                    ],
                  ),
                ],
              ),
            ),
          ));
  }
}
