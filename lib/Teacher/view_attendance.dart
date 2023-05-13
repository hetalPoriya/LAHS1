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
import 'package:little_angels/Teacher/attendance.dart';
import 'package:little_angels/Teacher/create_assignment.dart';
import 'package:little_angels/Teacher/home.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_drop_down.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../utils/network_handler.dart';

class TeacherViewAttendance extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherViewAttendance({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherViewAttendance> createState() => _TeacherViewAttendanceState();
}

class _TeacherViewAttendanceState extends State<TeacherViewAttendance> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  DateTime todayDate = DateTime.now();
  late DateTime _dateTime;
  String? dayselectedValue1;
  String? dayselectedValue2;
  String? dayselectedValue3;
  String? stuselectedValue1;
  String? stuselectedValue2;
  String? stuselectedValue3;
  String? stuselectedValue4;
  List month = ["January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"];
  List? _myStudents;
  var teacherMarkAttendanceController = Get.put(TeacherMarkAttendanceController());
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
    }
    else{
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
          length: 2,
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
                        context, const TeacherAttendance()),
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
                      "View Attendance",
                      style: titleTextStyle,
                    ),
                  ),
                  divider,
                  const TabBar(
                    tabs: [
                      Tab(
                        text: "Student Wise",
                      ),
                      Tab(
                        text: "Day Wise",
                      ),
                    ],
                    isScrollable: true,
                    labelColor: ColorConstants.kBlackColor,
                    labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    unselectedLabelColor: ColorConstants.kBlackColor,
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
    return Obx(
            () => teacherMarkAttendanceController.isLoading ==true?
        Center(
            child: Image.asset(
              "assets/loading.gif",
              height: 425.0,
              width: 425.0,
              fit: BoxFit.fitHeight,
            )
        ):Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: TabBarView(
              key: ValueKey(DateTime.now().toString()),
              physics: const NeverScrollableScrollPhysics(),
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
                        CustomDropDown(
                          hintText: "Select Class",
                          items: [
                            for(var i in teacherMarkAttendanceController.classesSections)
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
                          selectedValue: stuselectedValue1,
                          onChanged: (value) {
                            teacherMarkAttendanceController.classId(int.parse(value!));
                            setState((){
                              stuselectedValue1 = value;
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
                            for(var i in teacherMarkAttendanceController.classesSections)
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
                          selectedValue: stuselectedValue2,
                          onChanged: (value) async{
                            teacherMarkAttendanceController.sectionId(int.parse(value!));
                            await teacherMarkAttendanceController.getStudentsByClassSection();
                            setState(() {
                              stuselectedValue2 = value!;
                            });
                          },
                        ),
                        smallSizedBox,
                        Visibility(
                            visible: teacherMarkAttendanceController.studentVisible.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Student:",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                smallSizedBox,
                                CustomDropDown(
                                  hintText: "Select Student",
                                  items: [
                                    for(var i in teacherMarkAttendanceController.students)
                                      DropdownMenuItem<String>(
                                        value: i.studentId.toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Text(
                                            i.studentName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                  selectedValue: stuselectedValue3,
                                  onChanged: (value) async{
                                    teacherMarkAttendanceController.vStudentId(int.parse(value!));
                                    stuselectedValue3 = value;
                                  },
                                ),
                              ],
                            )),
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
                        DropdownButtonFormField(
                            items: [
                              for(var i=0; i<month.length; i++)
                                DropdownMenuItem<String>(
                                  value: i.toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      month[i],
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          hint: Text("Select Month"),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: ColorConstants.kBlackColor,
                          ),
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            contentPadding: const EdgeInsets.all(12.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          value: stuselectedValue4,
                          onChanged: (String? value) {
                            teacherMarkAttendanceController.attendanceMonth(int.parse(value!));
                            setState(() {
                              stuselectedValue4 = value;
                            });
                          },
                        ),
                        mediumSizedBox,
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              teacherMarkAttendanceController.teacherViewAttendance();
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              primary: const Color.fromRGBO(105, 80, 255, 1.0),
                            ),
                          ),
                        ),
                        largeSizedBox,
                        Visibility(
                          visible: teacherMarkAttendanceController.viewAttendance.value,
                          child:Padding(
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
                                      label: Text('Action'),
                                    ),
                                  ], rows: [
                                    for(var i = 0; i<teacherMarkAttendanceController.attendance.length;i++)
                                      DataRow(cells: [
                                        DataCell(Text('${i+1}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].admissionId}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].studentName}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].status}')),
                                      ]),
                                  ]),
                            ),
                          ),),
                      ],
                    ),
                  ],
                ),
                ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallSizedBox,
                        const Text(
                          "Class:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        smallSizedBox,
                        CustomDropDown(
                          hintText: "Select Class",
                          items: [
                            for(var i in teacherMarkAttendanceController.classesSections)
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
                          selectedValue: dayselectedValue1,
                          onChanged: (value) {
                            teacherMarkAttendanceController.dayclassId(int.parse(value!));
                            setState((){
                              dayselectedValue1 = value;
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
                            for(var i in teacherMarkAttendanceController.classesSections)
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
                          selectedValue: dayselectedValue2,
                          onChanged: (value) {
                            teacherMarkAttendanceController.sectionId(int.parse(value!));
                            setState((){
                              dayselectedValue2 = value;
                            });
                          },
                        ),
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
                                teacherMarkAttendanceController.attendanceDate.text =
                                    DateFormat('dd-MM-yyyy').format(date!);
                              });
                            },
                            controller: teacherMarkAttendanceController.attendanceDate,
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
                                      teacherMarkAttendanceController.attendanceDate.text = DateFormat('dd-MM-yyyy').format(date!);
                                    });
                                  },
                                  icon: Icon(Icons.calendar_month)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                              //  hintText: (_dateTime==null ? 'nothing':_dateTime.toString()),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              isDense: true,
                            )),
                        largeSizedBox,
                        mediumSizedBox,
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              teacherMarkAttendanceController.teacherViewAttendance();
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              primary: const Color.fromRGBO(105, 80, 255, 1.0),
                            ),
                          ),
                        ),
                        largeSizedBox,
                        Visibility(
                          visible: teacherMarkAttendanceController.viewAttendance.value,
                          child:Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: SingleChildScrollView(
                              child: teacherMarkAttendanceController.status == "This day's attendance not found"?
                              Center(child:Text("${teacherMarkAttendanceController.status}"))
                                  :DataTable(columnSpacing: 13,
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
                                      label: Text('Action'),
                                    ),
                                  ], rows: [
                                    for(var i = 0; i<teacherMarkAttendanceController.attendance.length;i++)
                                      DataRow(cells: [
                                        DataCell(Text('${i+1}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].admissionId}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].studentName}')),
                                        DataCell(Text('${teacherMarkAttendanceController.attendance[i].status}')),
                                      ]),
                                  ]),
                            ),
                          ),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
        );
  }
}

