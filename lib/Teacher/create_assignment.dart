// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unnecessary_null_comparison, non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:little_angels/Student/profile_page.dart';
import 'package:little_angels/utils/animated_navigation.dart';
import 'package:little_angels/utils/widgets/custom_page.dart';
import 'package:little_angels/utils/images.dart';
import 'package:little_angels/utils/strings.dart';
import 'package:little_angels/utils/utility.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
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
  String? selectedValue3;
  List<String> status = [
    'Active',
    'Disabled',
  ];

  TextEditingController _urlController = TextEditingController();
  TextEditingController _fileController = TextEditingController();
  TextEditingController _expiredateController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime todayDate = DateTime.now();
  late DateTime _dateTime;

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
        _fileController.text = _fileName!;
      });
    } catch (e) {
      //print(e);
    }
  }

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
                    image: AssetImage(AssetImages.create1),
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
          body: ListView(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            children: [
              Center(
                child: Text(
                  "Create Assignment",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.grey),
              smallSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Title:",
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    hintText: ("Assignment Title"),
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
                child: Row(
                  children: [
                    const Text(
                      "Class:",
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
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    // dropdownColor: Colors.grey,
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      'Select Class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
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
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Subject:",
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
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      'Select Subject',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: section
                        .map((section) => DropdownMenuItem<String>(
                              value: section,
                              child: Text(
                                section,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue1,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue1 = value!;
                      });
                    },
                  ),
                ),
              ),
              smallSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      "Section:",
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
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      'Select Section',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: section
                        .map((section) => DropdownMenuItem<String>(
                              value: section,
                              child: Text(
                                section,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue1,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue1 = value!;
                      });
                    },
                  ),
                ),
              ),
              smallSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Upload Image:",
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
                    controller: _fileController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
              ),
              smallSizedBox,
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Link:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
              Container(
                child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      hintText: ("Link"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      isDense: true,
                    )),
              ),
              smallSizedBox,
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
                  controller: _descriptionController,
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
                  "Schedule Date",
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
                      setState(() {
                        _dateTime = date!;
                        _dateController.text =
                            DateFormat('dd-MM-yyyy').format(date);
                      });
                    });
                  },
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    //  hintText: (_dateTime==null ? 'nothing':_dateTime.toString()),
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
                  "Expire Date",
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
                      setState(() {
                        _dateTime = date!;
                        _expiredateController.text =
                            DateFormat('dd-MM-yyyy').format(date);
                      });
                    });
                  },
                  controller: _expiredateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                  "Status:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      'Select Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: status
                        .map((status) => DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue3,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue3 = value!;
                      });
                    },
                  ),
                ),
              ),
              largeSizedBox,
              smallSizedBox,
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      log(_urlController.text);
                      log(_dateController.text);
                      log(_expiredateController.text);
                      log(_descriptionController.text);
                      log(_titleController.text);
                      log(_fileController.text);
                    },
                    child: const Text(
                      "Add",
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
              ),
              smallSizedBox,
            ],
          ),
        ));
  }
}
