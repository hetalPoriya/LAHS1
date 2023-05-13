// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields

import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/Teacher/Tests.dart';
import 'package:little_angels/Teacher/upload_video.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/colors.dart';
import 'package:little_angels/utils/constants.dart';
import 'package:little_angels/utils/widgets/custom_app_bar.dart';
import 'package:little_angels/utils/widgets/custom_drop_down.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';
import 'package:little_angels/utils/widgets/video_player.dart';

class AddTest extends StatefulWidget {
  final String? id;
  final String? name;
  const AddTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? Pickedfile;
  bool isLoading = false;
  File? fileToDisplay;

  void PickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result?.files.first.name;
        Pickedfile = result!.files.first;
        fileToDisplay = File(Pickedfile!.path.toString());

        print('File Nmae $_fileName');
      }
      setState(() {
        isLoading = false;
        _file1Controller.text = _fileName!;
      });
    } catch (e) {
      //print(e);
    }
  }

  late DateTime _dateTime;
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _questionController = TextEditingController();
  TextEditingController _file1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _file2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _file3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _file4Controller = TextEditingController();

  TextEditingController _file5Controller = TextEditingController();
  TextEditingController _validtillController = TextEditingController();
  String? selectedValue;
  List<String> items = [
    'I',
    'II',
    'III',
  ];
  String? selectedValue1;
  List<String> subjects = [
    'PHP',
    'Python',
    'DAA',
  ];
  String? selectedValue2;
  List<String> answer = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];
  DateTime todayDate = DateTime.now();
  int currentStep = 0;

  List<Step> getSteps() => <Step>[
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(
              "Create Test",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Class:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: CustomDropDown(
                    hintText: "Select Class",
                    items: items,
                    selectedValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
                smallSizedBox,
                const Text(
                  "Subject:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 42,
                  child: CustomDropDown(
                    hintText: "Select Subject",
                    items: subjects,
                    selectedValue: selectedValue1,
                    onChanged: (value) {
                      setState(() {
                        selectedValue1 = value!;
                      });
                    },
                  ),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Test Name:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    //controller: _titleController,
                    decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  hintText: ("Input Test Name"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Valid till",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                SizedBox(
                  height: 42,
                  child: TextField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1999),
                          lastDate: DateTime(2040),
                        ).then((date) {
                          setState(() {
                            _dateTime = date!;
                            _validtillController.text =
                                DateFormat('dd-MM-yyyy').format(date);
                          });
                        });
                      },
                      controller: _validtillController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: ("dd-mm-yyyy"),
                        suffixIcon: IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(2040),
                              ).then((date) {
                                setState(() {
                                  _dateTime = date!;
                                  _validtillController.text =
                                      DateFormat('dd-MM-yyyy').format(date);
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_month)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                ),
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text("Add QnA",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            content: Column(
              children: [
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
                smallSizedBox,
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
                smallSizedBox,
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
                smallSizedBox,
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
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Option 1",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    controller: _option1Controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Option 1"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
                smallSizedBox,
                SizedBox(
                  height: 35,
                  child: TextField(
                      onTap: () {
                        PickFile();
                      },
                      controller: _file1Controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: ("       No File Chosen"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: const Center(
                              child: Text('Choose file'),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        isDense: true,
                      )),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Option 2",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    controller: _option2Controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Option 2"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
                smallSizedBox,
                SizedBox(
                  height: 35,
                  child: TextField(
                      onTap: () {
                        PickFile();
                      },
                      controller: _file2Controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: ("       No File Chosen"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: const Center(
                              child: Text('Choose file'),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        isDense: true,
                      )),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Option 3",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    controller: _option3Controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Option 3"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
                smallSizedBox,
                SizedBox(
                  height: 35,
                  child: TextField(
                      onTap: () {
                        PickFile();
                      },
                      controller: _file3Controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: ("       No File Chosen"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: const Center(
                              child: Text('Choose file'),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        isDense: true,
                      )),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Option 4",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    controller: _option4Controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Option 4"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
                smallSizedBox,
                SizedBox(
                  height: 35,
                  child: TextField(
                      onTap: () {
                        PickFile();
                      },
                      controller: _file4Controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: ("       No File Chosen"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: const Center(
                              child: Text('Choose file'),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        isDense: true,
                      )),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Answer:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                SizedBox(
                  height: 40,
                  child: CustomDropDown(
                    hintText: "Select Answer",
                    items: answer,
                    selectedValue: selectedValue2,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Descriptions:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                TextField(
                    controller: _questionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    cursorWidth: 2.0,
                    // textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      //isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    )),
                smallSizedBox,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Upload File:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                SizedBox(
                  height: 35,
                  child: TextField(
                      onTap: () {
                        PickFile();
                      },
                      controller: _file5Controller,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        hintText: ("       No File Chosen"),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5)),
                            ),
                            child: const Center(
                              child: Text('Choose file'),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        isDense: true,
                      )),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: const Text("Assign Students",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            content: Center(
              child: Text("Assign Students"),
            ))
      ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
           leading: IconButton(
           alignment: Alignment.topLeft,
            icon: Icon(Icons.arrow_back,
            size: 35,
            color: Colors.black,),
            onPressed: ()=>AnimatedNavigation.pushReplacementAnimatedNavigation(context, TeacherTest()),),
         
        // automaticallyImplyLeading: true,
          toolbarHeight: 180,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
               // bottomRight: Radius.circular(20)
                ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetImages.test), fit: BoxFit.fill),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
             // bottomRight: Radius.circular(20),
            ),
          ),
        ),
        // extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Create Test",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      decorationThickness: 2.0,
                      decorationStyle: TextDecorationStyle.solid,
                      // wordSpacing: 8,
                      // letterSpacing: 2,
                      // shadows: [
                      //   Shadow(
                      //       color: Colors.black,
                      //       blurRadius: 2.0,
                      //       offset: Offset(3, 1))
                      // ]
                      ),
                ),
              ),
          
              Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.deepPurple)),
                child: Expanded(
                  child: Stepper(
                    elevation: 0,
                    physics: ScrollPhysics(),
                    type: StepperType.horizontal,
                    steps: getSteps(),
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep = currentStep == getSteps().length - 1;
                      if (isLastStep) {
                        print("completed");
                      } else {
                        setState(() => currentStep += 1);
                      }
                    },
                    onStepTapped: (step) =>
                        setState(() => currentStep = step),
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() => currentStep -= 1),
                    // controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                    //   Row(
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton(onPressed: onStepContinue,
                    //          child:Text("Next"),
                    //          ),
                    //       ),
                    //         Expanded(
                    //           child: ElevatedButton(onPressed: onStepCancel,
                    //                                    child:Text("Back"),
                    //                                    ),
                    //         ),
                    //     ],
                    //   ),
                    // },
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
